class MyClass:
    x = 10  # Атрибут класу
c = MyClass() # Створюємо екземпляр класу
MyClass.x = 100   # Змінюємо атрибут об'єкта класу
print(c.x)
c.x = 200  # Створюємо атрибут екземпляра
print(c.x, MyClass.x)  # 200 100.
