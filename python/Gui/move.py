
import pyautogui
import time

pyautogui.FAILSAFE = False

while True:
    pyautogui.moveRel(0, 10)
    time.sleep(3)
    pyautogui.moveRel(0, -10)
    time.sleep(3)
