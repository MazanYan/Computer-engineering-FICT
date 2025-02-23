from tkinter import *
def key(event):
    if event.char == event.keysym:
        msg ='Normal Key %r' % event.char
    elif len(event.char) == 1:
        msg ='Punctuation Key %r (%r)' % (event.keysym, event.char)
    else:
        msg ='Special Key %r' % event.keysym
    L.config(text=msg)
def do_mouse(eventname):
    def mouse_binding(event):
        msg = 'Mouse event %s' % eventname
        L.config(text=msg)
    L.bind_all('<%s>'%eventname, mouse_binding)
###########################################################
root = Tk()
prompt='Click any button, or press a key'
L = Label(root, text=prompt, width=len(prompt), font = "Arial 20")
L.pack()
L.bind_all('<Key>', key)
for i in range(1,4):
    do_mouse('Button-%s'%i)
    do_mouse('ButtonRelease-%s'%i)
    do_mouse('Double-Button-%s'%i)


root.mainloop(  )
