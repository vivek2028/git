try:
    # for Python2
    from Tkinter import *   ## notice capitalized T in Tkinter 
except ImportError:
    # for Python3
    from tkinter import *

import Tkinter as tk
import random

class Simon:
	def __init__(self,parent):
		self.parent=parent
		self.canvas=tk.Canvas(self.parent,height=400, width=400)
		self.canvas.pack()
		self.dark={'r':'darkred','g':'darkgreen','b':'darkblue','y':'darkgoldenrod'}
		self.light={'r':'red','g':'green','b':'blue','y':'goldenrod'}
		self.squares={  'r':self.canvas.create_rectangle(0,0,200,200,
											fill='darkred',outline='darkred'),
						'g':self.canvas.create_rectangle(200,0,400,200,fill='darkgreen',outline='darkgreen'),
						'b':self.canvas.create_rectangle(0,200,200,400,fill='darkblue',outline='darkblue'),
						'y':self.canvas.create_rectangle(200,200,400,400,fill='darkgoldenrod',outline='darkgoldenrod')}
		self.ids={v:k for k,v in self.squares.items()}
		self.high_score=0
		self.status=tk.Label(root,text='Prove Your memory power!!')
		self.status.pack()
		self.draw_board()
	
	def draw_board(self):
		self.pattern= random.choice('rgby')
		self.selections=''
		self.parent.after(1000, self.animate)
		
		
		
		
	def animate(self,idx=0):
		c=self.pattern[idx]
		self.canvas.itemconfig(self.squares[c], fill=self.light[c], outline=self.light[c])
		self.parent.after(500,lambda: self.canvas.itemconfig(self.squares[c],fill=self.dark[c],outline=self.dark[c]))
		idx+=1
		if idx< len(self.pattern):
			self.parent.after(1000,lambda: self.animate(idx))
		else:
			self.canvas.bind('<1>',self.select)
			print(self.pattern)
		
	def select(self, event=None):
		id=self.canvas.find_withtag("current")[0]
		color=self.ids[id]
		self.selections+=color
		self.canvas.itemconfig(id,
								fill=self.light[color],outline=self.light[color])
		self.parent.after(500,lambda: self.canvas.itemconfig(id,
								fill=self.dark[color],outline=self.dark[color]))
		if self.pattern == self.selections:
			self.canvas.unbind('<1>')
			self.status.config(text='Right!')
			self.parent.after(1000,lambda: self.status.config(text=''))
			self.pattern+=random.choice('rgby')
			self.selections=''
			self.high_score=max(self.high_score,len(self.pattern))
			self.status.config(text=self.high_score)			
			self.parent.after(5000, lambda: self.status.config(text=''))
			print(self.high_score)
			self.parent.after(2000,self.animate)
		elif self.pattern[len(self.selections)-1]!=color:
			self.canvas.unbind('<1>')
			self.status.config(text="Nope!")
			self.parent.after(2000,lambda: self.status.config(text=''))
			self.high_score=0
			self.parent.after(2000,self.draw_board)
			print(self.pattern,self.selections)
		
root=tk.Tk()
simon=Simon(root)
root.mainloop()		