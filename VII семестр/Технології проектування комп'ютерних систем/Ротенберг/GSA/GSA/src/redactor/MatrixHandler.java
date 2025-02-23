package redactor;

import redactor.gui.graphicalElements.ConditionalVertex;
import redactor.gui.graphicalElements.Entity;

import java.util.*;

/**
 * Creates MSA using list  of existing vertexes.
 */
public class MatrixHandler {
    List<Entity> listOfEntities;
    List<Entity> listOfOperations;
    Set<Entity> visitedOperations;
    String[][] matrix;
    int sizeOfMatrix;
    TreeMap<String, String> operationValues;
    TreeMap<String, String> conditionValues;
    Map<String, Entity> abbreviationToEntityMap;

    List<List<String>> fullWays;
    List<List<String>> cycles;
    List<List<String>> endlessCycles;

    public MatrixHandler(List<Entity> listOfEntities) {
        this.listOfEntities = listOfEntities;
        visitedOperations = new HashSet<Entity>();
        listOfOperations = new ArrayList<Entity>();
        fullWays = new ArrayList<List<String>>();
        cycles = new ArrayList<List<String>>();
        endlessCycles = new ArrayList<List<String>>();
        operationValues = new TreeMap<String, String>();
        conditionValues = new TreeMap<String, String>();
        abbreviationToEntityMap = new HashMap<String, Entity>();

        update();
    }

	public void update() {
		listOfOperations.clear();
		fullWays.clear();
		cycles.clear();
        endlessCycles.clear();
		visitedOperations.clear();
        operationValues.clear();
        conditionValues.clear();

		if (listOfEntities.isEmpty())
			return;

		Entity begin = listOfEntities.get(0);
        begin.setNumber(0);
		listOfOperations.add(begin);   //add begin vertex
        abbreviationToEntityMap.put("P0", begin);

		int maxNumberOfOperation = 0;

        for (Entity entity : listOfEntities) {      //add operations
            if ("OperationalVertex".equals(entity.getName())) {
                listOfOperations.add(entity);
                if (entity.getNumber() > maxNumberOfOperation)
                    maxNumberOfOperation = entity.getNumber();
                abbreviationToEntityMap.put("P" + entity.getNumber(), entity);
            }
            else if ("Condition".equals(entity.getName())) {
                abbreviationToEntityMap.put("C" + entity.getNumber(), entity);
            }
        }

        Entity end = listOfEntities.get(1);
		end.setNumber(maxNumberOfOperation + 1);
		listOfOperations.add(end);    //add end vertex
        abbreviationToEntityMap.put("P" + end.getNumber(), end);

		if (matrix == null || listOfOperations.size() != matrix.length) {
			createEmptyMatrix();
		} else {
			clearMatrix();
		}
		useFillMatrix();
		findAllWays(1, createNewWay());
        findEndlessCycles();
        findHangingCycles();
	}

    private void collectConditions(String conditionString, Set<String> collectedNodes) {
        String conditions[] = conditionString.split(";");
        for (String condition : conditions) {
            if (!"1".equals(condition)) {
                if (condition.charAt(0) == '(') {
                    String nodes[] = condition.substring(1, condition.length()-1).split(",");
                    for (String node : nodes) {
                        if (node.isEmpty())
                            continue;
                        if (node.charAt(0) == '!')
                            node = node.substring(1);
                        collectedNodes.add(node);
                    }
                }
                else {
                    if (condition.charAt(0) == '!')
                        condition = condition.substring(1);
                    collectedNodes.add(condition);
                }
            }
        }
    }

    private void collectOperations(List<String> path, Set<String> operations) {
        for (String node : path) {
            if (node.charAt(0) == 'P' && !operations.contains(node)) {
                operations.add(node);
            }
        }
    }

    public ArrayList<String> getTextConnections() {
        ArrayList<String> list = new ArrayList<String>();
        for (int i = 1; i < sizeOfMatrix; i++) {
            for (int j = 1; j < sizeOfMatrix; j++) {
                if (!matrix[i][j].equals("0")) {
                    list.add(matrix[i][0] + " " + matrix[i][j] + " " + matrix[0][j]);
                }
            }
        }
        return list;
    }

    public TreeMap<String, String> tableOfOperationValues() {

        for (Entity listOfEntity : listOfEntities) {
            if ("OperationalVertex".equals(listOfEntity.getName())) {
                operationValues.put("P" + listOfEntity.getNumber(), listOfEntity.getInitialValue());
            }
        }


        return operationValues;
    }

    public TreeMap<String, String> tableOfConditionValues() {

        for (Entity listOfEntity : listOfEntities) {
            if ("Condition".equals(listOfEntity.getName())) {
                conditionValues.put("C" + listOfEntity.getNumber(), listOfEntity.getInitialValue());
            }
        }

        return conditionValues;
    }

    /**
     * Finds parameters for fillMatrix(int row, Entity currentEntity, List<String> conditions)
     * and calls this method. Fills MSA by all existing connections.
     */

    public void useFillMatrix() {
        Entity begin = listOfOperations.get(0);
        Entity init = getLinkedEntity(begin);
        LinkedHashSet<String> conditions = new LinkedHashSet<String>();
        if (init != null) {
            visitedOperations.add(begin);
            fillMatrix(1, init, conditions);
        }

//        System.out.println("visited operations ");
//        System.out.println(visitedOperations);
//
//        System.out.println("visited conditions");
//        System.out.println(conditions);

        // next seems to be redundant, but anyway..
        conditions.clear();
        // next 2 lines: obtain a list of operations not visited during first pass
        List<Entity> hangingEntities = new ArrayList<Entity>(listOfOperations.size());
        hangingEntities.addAll(listOfOperations);
        hangingEntities.removeAll(visitedOperations);
        while (!hangingEntities.isEmpty()) {
            /* next brings some extra and maybe unneeded complexity but I find it useful
                * take first entity without input connection
                * if no such entity => we have only hanging cycles and can start from any entity, take first
                * do the same as with begin entity: call fillMatrix()
                */
            begin = null;
            for (Entity hangingEntity : hangingEntities) {
                if (!hangingEntity.isInputUsed()) {
                    begin = hangingEntity;
                    break;
                }
            }
            if (begin == null)
                begin = hangingEntities.get(0);
            init = getLinkedEntity(begin);
            if (init != null) {
                visitedOperations.add(begin);
                fillMatrix(findRow(begin), init, conditions);
                conditions.clear();
                hangingEntities.removeAll(visitedOperations);
            } else {
                hangingEntities.remove(begin);
            }
        }
    }

    private Entity getLinkedEntity(Entity entity) {
        List<Entity> outputLink = entity.getOutputLink();
        if (outputLink == null)
            return null;
        return outputLink.get(outputLink.size() - 1);
    }


    private void createEmptyMatrix() {
        sizeOfMatrix = listOfOperations.size();
        matrix = new String[sizeOfMatrix][sizeOfMatrix];

	    clearMatrix();
    }

	private void clearMatrix() {
		matrix[0][0] = "";

		for (int i = 1; i < sizeOfMatrix; i++) {
			matrix[0][i] = "P" + listOfOperations.get(i).getNumber();

		}
		for (int i = 1; i < sizeOfMatrix; i++)
			matrix[i][0] = "P" + listOfOperations.get(i - 1).getNumber();

		for (int i = 1; i < sizeOfMatrix; i++)
			for (int j = 1; j < sizeOfMatrix; j++)
				matrix[i][j] = "0";
	}

    public int findRow(Entity entity) {

        String entityNumber = String.valueOf(entity.getNumber());
        for (int i = 1; i < sizeOfMatrix; i++)
            if (matrix[i][0].substring(1).equals(entityNumber))
                return i;


        return -1;
    }

    public int findColumn(Entity entity) {
        String entityNumber = String.valueOf(entity.getNumber());
        for (int i = 1; i < sizeOfMatrix; i++)
            if (matrix[0][i].substring(1).equals(entityNumber))
                return i;


        return -1;
    }

    public static boolean isOperation(Entity entity) {
        return ("Begin").equals(entity.getName()) || ("OperationalVertex".equals(entity.getName()))
                || ("End".equals(entity.getName()));
    }

    public String conditionToString(LinkedHashSet<String> conditions) {
        if (conditions.isEmpty())
            return "1";
        StringBuilder result = new StringBuilder();
        for (String condition : conditions) {
            result.append(result.length() == 0 ? "(" : ",").append(condition);
        }
        return result.append(")").toString();
    }

    /**
     * Method that finds all connections with currentEntity.
     * Algorithm:
     * 1. If currentEntity is operational vertex:
     * - fill cell of matrix by existing conditions
     * - call fillMatrix
     * - return
     * 2. Method fond condition.
     * Call fillMatrix  with next parameters:
     * * matrixRow
     * * end of output link
     * * list of conditions
     * 3. Invert last of existing conditions
     * 4. Call fillMatrix with next parameters:
     * * matrixRow
     * * end of output2 link
     * * list conditions
     * 5. Remove last condition
     * 6. Return
     *
     * @param row           row in matrix for current entity
     * @param currentEntity entity for handling
     * @param conditions    list of fond conditions
     */

    private void fillMatrix(int row, Entity currentEntity, LinkedHashSet<String> conditions) {
        if (isOperation(currentEntity)) {

            updateMatrixCell(row, findColumn(currentEntity), conditionToString(conditions));

            if (visitedOperations.contains(currentEntity))
                return;
            visitedOperations.add(currentEntity);

            Entity linkedEntity = getLinkedEntity(currentEntity);
            if (linkedEntity == null)
                return;

            fillMatrix(findRow(currentEntity), linkedEntity, new LinkedHashSet<String>());
            return;
        }

        if (currentEntity.getOutputLink() != null) {
            int outputValue = ((ConditionalVertex) currentEntity).getLeftOutputValue();
            String marker = ((outputValue == 0) ? "!" : "") + "C" + currentEntity.getNumber();
            if (!conditions.contains(marker)) { // avoid cycles through conditions
                conditions.add(marker);
                fillMatrix(row, currentEntity.getOutputLink().get(currentEntity.getOutputLink().size() - 1), conditions);
                conditions.remove(marker);
            }
        }

        if (currentEntity.getOutput2Link() != null) {
            int outputValue = ((ConditionalVertex) currentEntity).getRightOutputValue();
            String marker = ((outputValue == 0) ? "!" : "") + "C" + currentEntity.getNumber();
            if (!conditions.contains(marker)) { // avoid cycles through conditions
                conditions.add(marker);
                fillMatrix(row, currentEntity.getOutput2Link().get(currentEntity.getOutput2Link().size() - 1), conditions);
                conditions.remove(marker);
            }
        }
    }

    private void updateMatrixCell(int row, int column, String value) {
        if ("0".equals(matrix[row][column])) {
            matrix[row][column] = value;
        } else {
            matrix[row][column] = matrix[row][column] + ";" + value;
        }
    }

    public void outputMatrix() {
        for (int i = 0; i < sizeOfMatrix; i++) {
            for (int j = 0; j < sizeOfMatrix; j++)
                System.out.print("\t\t" + matrix[i][j]);
            System.out.println();
        }

    }

    public String[][] getMatrix() {
        return matrix;
    }

    public void findAllWays(int row, List<String> currentWay) {

        for (int i = 1; i < sizeOfMatrix; i++) {
            if (!matrix[row][i].equals("0")) {
	            String validConditions = matrix[row][i];
	            if (!"1".equals(matrix[row][i])) {
		            validConditions = checkEndlessConditionCycle(matrix[row][i]);
	            }
	            // if (!currentWay.contains(matrix[0][i])) {
	            // previous one is much better ;)
                if (!inWay(matrix[0][i], currentWay)) {
                    currentWay.add(validConditions);
                    currentWay.add(matrix[0][i]);

                    if (i != sizeOfMatrix - 1) {
                        findAllWays(i + 1, currentWay);

                        currentWay.remove(currentWay.size() - 1);
	                    currentWay.remove(currentWay.size() - 1);


                    } else {
                        List<String> foundWay = new ArrayList<String>(currentWay.size());
                        foundWay.addAll(currentWay);
                        fullWays.add(foundWay);
                        currentWay.remove(currentWay.size() - 1);
                        currentWay.remove(currentWay.size() - 1);
                        return;
                    }

                }
                else {
                    List<String> currentCycle = new ArrayList<String>(currentWay.size());// extractCyclesFromPath(currentWay, matrix[0][i], matrix[row][i]);
                    currentCycle.addAll(currentWay);

//                    if ("1".equals(matrix[row][i])) {
//                        int startNode = currentWay.indexOf(matrix[0][i]) + 1;
//                        while (startNode<currentWay.size()) {
//                            if (!"1".equals(matrix[0][i]))
//                                break;
//                            startNode += 2;
//                        }
//                        if (startNode >= currentWay.size()) {
//                            // handle endless cycle here
//                        }
//                    }
                    cycles.add(currentCycle);
                    // This 'return' prevents cycles duplication
                    // but leads to loss of valid paths
                    //return;
                }
            }
        }

        return;
   //     filterCycles();

    }

    private void findEndlessCycles() {
        Set<String> allWaysNodes = new HashSet<String>();
        for (List<String> path : fullWays) {
            collectOperations(path, allWaysNodes);
        }
        // detect endless cycles and move them from cycles list to endless cycles list
        HashSet<String> cycleSet = new HashSet<String>();
        Iterator<List<String>> itCycles = cycles.iterator();
        while (itCycles.hasNext()) {
            cycleSet.clear();
            List<String> cycle = itCycles.next();
            collectOperations(cycle, cycleSet);

            if (cycleSet.isEmpty() || !cycleSet.removeAll(allWaysNodes) ){
                endlessCycles.add(cycle);
                itCycles.remove();
            }
        }
        // Collect and Mark all entities in endless cycles
        cycleSet.clear();
        // 1. collect
        for (List<String> cycle : endlessCycles) {
            for (String node : cycle) {
                if (node.charAt(0) == 'P')
                    cycleSet.add(node);
                else if (!"1".equals(node)) {
                    collectConditions(node, cycleSet);
                }
            }
        }
        // 2. Mark
        for (Map.Entry<String, Entity> entry : abbreviationToEntityMap.entrySet()) {
            entry.getValue().setInCycle(cycleSet.contains(entry.getKey()));
        }
    }

/*
    private List<String> extractCyclesFromPath(List<String> path, String cycledOperation, String lastCondition) {
        List<String> cycle = new LinkedList<String>();
        int cycleOperationIndex = path.indexOf(cycledOperation);
        if ("1".equals(lastCondition))
            cycle.addAll(path.subList(cycleOperationIndex, path.size()));
        else {
            String cyclePreCondition = path.get(cycleOperationIndex - 1);
            if ("1".equals(cyclePreCondition)) {
                cycle.addAll(path.subList(cycleOperationIndex, path.size()));
                cycle.add(lastCondition);
            }
            else {
                String cyclePreConditions[] = cyclePreCondition.split(";");
                List<String> lastConditionsChain = conditionToChain(lastCondition);
                for (int i=0; i<cyclePreConditions.length; i++) {
                    if ("1".equals(cyclePreConditions[i]))
                        continue;
                    List<String> preConditionsChain = conditionToChain(cyclePreConditions[i]);
                    ListIterator<String> lastIt = lastConditionsChain.listIterator(lastConditionsChain.size());
                    ListIterator<String> preIt = preConditionsChain.listIterator(preConditionsChain.size());
                    int sameTailLength = preConditionsChain.size();
                    while (lastIt.hasPrevious() && preIt.hasPrevious() && lastIt.previous().equals(preIt.previous()))
                        sameTailLength--;
                    if (sameTailLength > 0) {
                        cycle.addAll(preConditionsChain.subList(sameTailLength, preConditionsChain.size()));
                        cycle.addAll(path.subList(cycleOperationIndex, path.size()));
                    }
                }
            }
        }

        return cycle;
    }

    private List<String> conditionToChain(String condition) {
        return Arrays.asList(condition.substring(1, condition.length() - 1).split(","));
    }
*/

    public boolean inWay(String name, List<String> path) {
        for (String pathItem : path) {
            if (name.equals(pathItem))
                return true;
        }
        return false;
    }

    public boolean onlyOperations(ArrayList<String> list) {
        for (String aList : list) {
            if (!(aList.substring(0, 1).equals("P")))
                return false;
        }

        return true;
    }
    
    public void removeAllBeforeCycleBegin(List<String> cycle){
        String item = cycle.get(cycle.size()-1);
        for (int i = 0; i<cycle.size()-1; i++){
            if (!item.equals(cycle.get(i))) {
                cycle.remove(i);
                i=0;
            }

           else return;
        }

    }
    
    public void filterCycles(){
        for (List<String> cycle : cycles) {
            removeAllBeforeCycleBegin(cycle);
        }
    }

    public List<List<String>> getCycles() {
        return cycles;
    }

    public List<List<String>> getEndlessCycles() {
        return endlessCycles;
    }

    public void printCycles() {

        filterCycles();


        if (cycles.isEmpty())
            System.out.println("No cycles");
        else {
            System.out.println("All cycles");
            for (List<String> cycle : cycles) {
                for (int j = 0; j < cycle.size(); j++) {

                    if (!cycle.get(j).equals("1")) {
                        System.out.print(cycle.get(j));

                        if (j < cycle.size() - 1)
                            System.out.print(" ---> ");
                        else
                            System.out.println();
                    }

                }
            }
        }

    }

    public void printWays() {

        if (fullWays.isEmpty())
            System.out.println("No ways");
        else {
            System.out.println("All ways from begin to end");
            for (int i = 0; i < fullWays.size(); i++) {
                for (int j = 0; j < fullWays.get(i).size(); j++) {

                    if (!fullWays.get(i).get(j).equals("1")) {
                        System.out.print(fullWays.get(i).get(j));

                        if (j < fullWays.get(i).size() - 1)
                            System.out.print(" ---> ");
                        else
                            System.out.println();
                    }

                }
            }
        }

    }

    public List<List<String>> getFullWays() {
        return fullWays;
    }

    public boolean isOperation(String name) {
        return name.substring(0, 1).equals("P");
    }

    public List<String> createNewWay() {
        List<String> list = new ArrayList<String>();
        list.add("P0");

        return list;
    }

	private String checkEndlessConditionCycle(String conditionalPaths) {
		if (conditionalPaths.indexOf(';') == -1) {
			return conditionalPaths;
		}
		StringBuilder validConditions = new StringBuilder();
		String paths[] = conditionalPaths.split(";");
		for (int i=0; i<paths.length; i++) {
			if (!"1".equals(paths[i]) && paths[i].contains(",")) {
				String pathNodes[] = paths[i].substring(1, paths[i].length()-1).split(",");
				String first = pathNodes[0];
				if (first.charAt(0) == '!')
					first = first.substring(1);
				String last = pathNodes[pathNodes.length - 1];
				if (last.charAt(0) == '!')
					last = last.substring(1);
				if (!first.equals(last)) {
					if (validConditions.length() > 0)
						validConditions.append(';');
					validConditions.append(paths[i]);
				}
				else {
					List<String> conditionalCycle = Arrays.asList(pathNodes);
                    // TODO handle endless cycle
					endlessCycles.add(conditionalCycle.subList(0, conditionalCycle.size()-1));
				}
			}
			else {
				if (validConditions.length() > 0)
					validConditions.append(';');
				validConditions.append(paths[i]);
			}
		}
		return validConditions.toString();
	}

    public void setListOfEntities(List<Entity> listOfEntities) {
        this.listOfEntities = listOfEntities;
    }

    private void findHangingCycles() {
        Set<String> endpoints = new HashSet<String>(); // already visited nodes
        Set<String> hangingOperations = new HashSet<String>(); // nodes w/o incoming, not a part of any cycle
        for (List<String> path : fullWays) { // collect ops connected to begin -> end paths, these are endpoints
            collectOperations(path, endpoints);
        }
        for (int i=1; i<matrix.length; i++) { // collect nodes w/o out connection, these are endpoints too
            if (endpoints.contains(matrix[i][0]))
                continue;
            Entity entity = abbreviationToEntityMap.get(matrix[i][0]);
            if (!entity.isOutputUsed()) { // this should be done by checking for matrix row full of "0"
                endpoints.add(matrix[i][0]);
            }
            // collect also nodes w/o incoming to skip them looking for hanging cycles
            if (!entity.isInputUsed()) { // this should be done by checking for matrix column full of "0"
                hangingOperations.add(matrix[i][0]);
            }
        }
        for (int i=1; i<matrix.length; i++) {
            if (endpoints.contains(matrix[i][0]) || hangingOperations.contains(matrix[i][0]))
                continue;
            List<String> path = new LinkedList<String>();
            path.add(matrix[i][0]);

            walkThroughPath(i, path, endpoints);
        }
    }

    private void walkThroughPath(int row, List<String> path, Set<String> endpoints) {
        for (int i = 1; i < sizeOfMatrix; i++) {
            if (!matrix[row][i].equals("0")) {
                if (endpoints.contains(matrix[0][i])) // we come to node already visited on previous passes
                    continue;
                String validConditions = matrix[row][i];
                if (!"1".equals(matrix[row][i])) {
                    validConditions = checkEndlessConditionCycle(matrix[row][i]);
                }
                // if (!currentWay.contains(matrix[0][i])) {
                // previous one is much better ;)
                if (!inWay(matrix[0][i], path)) {
                    path.add(validConditions);
                    path.add(matrix[0][i]);

                    walkThroughPath(i + 1, path, endpoints);

                    path.remove(path.size() - 1);
                    path.remove(path.size() - 1);
                }
                else {
                    List<String> currentCycle = new ArrayList<String>(path.size() + 2);// extractCyclesFromPath(currentWay, matrix[0][i], matrix[row][i]);
                    currentCycle.addAll(path);

                    // TODO check for conditions presence, cycle is endless without them
                    boolean endless = false;
                    for (int j=1; j<currentCycle.size(); j++) {
                        if (!"1".equals(currentCycle.get(j))) {
                            endless = true;
                            break;
                        }
                    }
                    currentCycle.add(validConditions);
                    currentCycle.add(matrix[0][i]);
                    if (endless)
                        endlessCycles.add(currentCycle);
                    else
                        cycles.add(currentCycle);
                }
            }
        }
        endpoints.add(matrix[row][0]); // not walk through this row again??
    }
}

