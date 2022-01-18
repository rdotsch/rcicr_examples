# RCIC DEMO TASK 
# Script by Ron Dotsch (r.dotsch@uu.nl)

from psychopy import visual, event, core, gui
from os import listdir
from random import randint

# settings
defaultstimulidir = './stimuli/'
defaultdatafile = 'rcic.csv'
defaultwinsize = 800


info = {'Instruction':'happy?', 'Stimuli folder':defaultstimulidir, 'Data file':defaultdatafile, 'Window size':defaultwinsize, 'ITI':0.5}
infoDlg = gui.DlgFromDict(dictionary=info, title='rcicr demo', order=['Instruction', 'Stimuli folder', 'Data file'])
if infoDlg.OK:
    stimulidir = info['Stimuli folder']
    datafile = info['Data file']
    instruction = info['Instruction']
    winsize = (info['Window size'], info['Window size'])
    iti = info['ITI']
else:
    core.quit()
    
win = visual.Window(size=winsize)
mouse = event.Mouse()

# Load stimuli
stim = [f for f in listdir (stimulidir) if '.jpg' in f]
ntrials = len(stim) / 2

stimleft = visual.ImageStim(win, pos=(-0.5, 0), size = (0.9, 0.9))
stimright = visual.ImageStim(win, pos=(0.5, 0), size= (0.9, 0.9))

#reminderleft = visual.TextStim(win, text='A', pos=(-0.5, -0.6))
#reminderright = visual.TextStim(win, text='B', pos=(0.5, -0.6))
reminderinstr = visual.TextStim(win, text=instruction, pos=(0, 0.6))

#reminderleft.setAutoDraw(True)
#reminderright.setAutoDraw(True)
reminderinstr.setAutoDraw(True)

dataf = open(datafile, 'w')
dataf.write('trial,stimleftf,stimrightf,selected,selectedstim\n')
dataf.close()


for trial in range(ntrials) :

    oristimf = stim[(trial * 2) + 1]
    invstimf = stim[(trial * 2)]

    if randint(0,1) == 0 :
        stimleftf = oristimf
        stimrightf = invstimf
    else :
        stimleftf = invstimf
        stimrightf = oristimf

    stimleft.setImage(stimulidir + stimleftf)
    stimleft.draw()
    
    stimright.setImage(stimulidir + stimrightf)
    stimright.draw()
    
    win.flip()
    
    selected = False
    
    while not selected:
        for key in event.getKeys():
            if key in ['escape','q']:
                core.quit()
                
        if mouse.isPressedIn(stimleft) :
            selected = 'left'
            selectedstim = stimleftf
        elif mouse.isPressedIn(stimright):
            selected = 'right'
            selectedstim = stimrightf
        
    
    if selected == 'left' :
        stimright.opacity = 0.25
    elif selected == 'right' :
        stimleft.opacity = 0.25
    stimright.draw()
    stimleft.draw()
    
    stimleft.opacity = 1.0
    stimright.opacity = 1.0
    
    win.flip()
    
    while mouse.getPressed()[0] :
        core.wait(0.01)
    
    
    dataf = open(datafile, 'a')
    dataline = ','.join([str(i) for i in [trial, stimleftf, stimrightf, selected, selectedstim]])
    dataf.write(dataline + '\n')
    dataf.close()
    
    core.wait(iti)
    
win.close()
