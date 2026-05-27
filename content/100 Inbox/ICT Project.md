---
excalidraw-plugin: parsed
tags:
  - excalidraw
excalidraw-open-md: true
image: ICT Project.svg
dg-publish: true
---

```

import time

import random

  

# sentence lists

  

easy_sentences = [

    "the cat sat on the mat",

    "i love to eat pizza on fridays",

    "the sun rises in the east",

    "she sells sea shells by the sea shore",

    "my dog likes to play in the park",

]

  

medium_sentences = [

    "the quick brown fox jumps over the lazy dog",

    "practice makes perfect when learning to type faster",

    "a good programmer writes code that humans can understand",

    "technology is changing the world at a rapid pace",

    "consistency and hard work are the keys to success",

]

  

hard_sentences = [

    "sphinx of black quartz judge my vow and keep it forever",

    "the algorithm efficiently processed all twenty six unique variables",

    "cybersecurity professionals must constantly adapt to evolving digital threats",

    "python is a versatile high level programming language used worldwide",

    "artificial intelligence is transforming industries across the entire globe",

]

  

#file functions

  

def save_score(name, wpm, accuracy, difficulty):

    with open("scores.txt", "a") as f:

        f.write("name: " + name + "\n")

        f.write("difficulty: " + difficulty + "\n")

        f.write("wpm: " + str(wpm) + "\n")

        f.write("accuracy: " + str(accuracy) + "%\n")

        f.write("--------------------\n")

  

def view_scores():

    print("Score History")

    try:

        with open("scores.txt", "r") as f:

            content = f.read()

            if content == "":

                print("No scores yet.")

            else:

                print(content)

    except FileNotFoundError:

        print("No scores yet.")

  

def clear_scores():

    with open("scores.txt", "w") as f:

        f.write("")

    print("All scores cleared.")

  

#calculation functions

  

def calculate_wpm(start_time, end_time, sentence):

    time_taken = end_time - start_time  # in seconds

    minutes = time_taken / 60

    word_count = len(sentence.split())

    wpm = round(word_count / minutes)

    return wpm

  

def calculate_accuracy(original, typed):

    original_chars = list(original)

    typed_chars = list(typed)

  

    correct = 0

    total = len(original_chars)

    for i in range(min(len(original_chars), len(typed_chars))):

        if original_chars[i] == typed_chars[i]:

            correct += 1

  

    accuracy = round((correct / total) * 100)

    return accuracy

  

#round logic

  

def play_round(name, difficulty, best_wpm):

  

    # pick a random sentence based on chosen difficulty

    if difficulty == "1":

        sentence = random.choice(easy_sentences)

        level_name = "easy"

    elif difficulty == "2":

        sentence = random.choice(medium_sentences)

        level_name = "medium"

    else:

        sentence = random.choice(hard_sentences)

        level_name = "hard"

  

    print("Type this sentence:")

    print("  " + sentence)

    input("Press enter when ready...")

  

    # timer starts just before input and stops right after

    start_time = time.time()

    typed = input("> ")

    end_time = time.time()

  

    wpm = calculate_wpm(start_time, end_time, sentence)

    accuracy = calculate_accuracy(sentence, typed)

  

    print("Results")

    print("Wpm:        " + str(wpm))

    print("Accuracy:   " + str(accuracy) + "%")

    print("Difficulty: " + level_name)

  

    # update personal best if this round was faster

    if wpm > best_wpm:

        best_wpm = wpm

        print("New personal best!")

  

    print("Session best: " + str(best_wpm) + " wpm")

  

    if accuracy == 100:

        print("Perfect accuracy")

    elif accuracy >= 80:

        print("Good job")

    else:

        print("Get better")

  

    save_score(name, wpm, accuracy, level_name)

    print("Score saved")

  

    return best_wpm

  

# main menu

def main():

    print("TYPING TEST")

  

    name = input("Enter your name: ")

    while name == "":

        print("Name can't be empty.")

        name = input("Enter your name: ")

  

    best_wpm = 0  # tracks highest wpm this session

  

    while True:

        print("1. Play")

        print("2. View scores")

        print("3. Clear scores")

        print("4. Quit")

  

        choice = input("Choice: ")

  

        if choice == "1":

            print("1. Easy")

            print("2. Medium")

            print("3. Hard")

            difficulty = input("Difficulty: ")

            if difficulty in ["1", "2", "3"]:

                best_wpm = play_round(name, difficulty, best_wpm)

            else:

                print("Invalid, try again.")

  

        elif choice == "2":

            view_scores()

  

        elif choice == "3":

            clear_scores()

  

        elif choice == "4":

            print("Final best: " + str(best_wpm) + " wpm")

            break

  

        else:

            print("Invalid, try again.")

  

main()
```


## 1. Program Initialization & Configuration

Before the game even starts, your program needs to set up its assets and environment.
- **System Imports:** Bring in `time` (for WPM math), `os` (for clearing the screen), and `random` (to shuffle or pick words).
- **Word List Arrays:** Define three distinct Python lists containing words of varying complexity:
    - `easy_words`: Short 3–4 letter words (e.g., _cat, tree, code, play_).
    - `medium_words`: 5–7 letter words (e.g., _python, matrix, banana, escape_).
    - `hard_words`: Longer words or short sentences with basic punctuation.

## 2. The Main Menu Loop

A welcoming text interface that keeps the program running continuously until the user chooses to exit.
- **Visual Banner:** A clean text-art header (e.g., === MONKEYTYPE TERMINAL CLONE ===
- **Navigation Options:** Give the user distinct paths:
    1. Start Typing Test
    2. View Instructions / How WPM is calculated
    3. Quit Program
- **Input Validation:** Use conditional checks (`if/else`) to ensure the user only types valid options. If they enter a typo or a random symbol, the menu smoothly refreshes instead of crashing.
## 3. Pre-Game Settings (Difficulty Selector)
Once the user decides to play, they get to customize their session.
- **Difficulty Prompt:** Ask the user to choose their challenge level (Easy, Medium, or Hard).
- **Dynamic Array Assignment:** Based on their choice, assign the corresponding list to a generic variable like `active_word_list`. This prevents you from having to write three separate game loops!
## 4. The Core Gameplay Loop
This is where the user interacts with the test. It runs sequentially through your chosen array.
- **Screen Refresh:** On every single turn of the loop, execute `os.system('cls')` (or `'clear'`) so the text remains stationary and focused in one spot on the terminal. 
- **Session Timer Start:** Grab the exact starting timestamp using `time.time()` right before the first word appears.
- **Input Collection:**
    - Display the current target word clearly.
    - Prompt the user for input.
    - Append their typed response into a secondary empty list called `user_inputs
## 5. Post-Game Analytics & Data Processing
Once the typing loop concludes, the timer stops, and your array logic processes the results.
- **Session Timer End:** Grab the finishing timestamp and subtract the start time to get `total_time_seconds`.
- **Side-by-Side Array Comparison:** Run a `for` loop using `range(len(active_word_list))` to check matching indices:
    - Compare `active_word_list[i]` directly against `user_inputs[i]`.
    - Increment a `correct_words` counter for every exact match.
- **Statistical Math:**
    - **Accuracy:** Calculation of $(\text{correct\_words} / \text{total\_words}) \times 100$.
    - **WPM (Words Per Minute):** Standard calculation based on total characters typed divided by five, scaled to a 60-second minute.

## 6. The Results Display & Polish
Presenting the performance feedback to the user in a visually engaging way.
- **ANSI Color-Coded Performance Review:** Print the list of words back to the user. Use terminal escape codes (`\033[92m` for green, `\033[91m` for red) to highlight which words they nailed and which ones they mistyped.
- **Performance Rank:** Use an `if/elif` structure to award a tier/rank based on their accuracy percentage (e.g., $95\%+ = \text{S Rank}$, $85\%+ = \text{A Rank}$, etc.).
- **The Replay Prompt:** Ask the user if they want to play again. If yes, loop them back to the main menu; if no, break the master loop and print a clean exit message.


![[ICT Project.svg]]




# Excalidraw Data

## Text Elements
Shitty ass monkey type clone ^VoJObFut

Save_score ^Y6dcJljo

view_scores ^8GCKohQo

Clear_scores ^VXufW7b9

Calculate_wpm ^AFe3xUTe

Calculate_accuracy ^UnckQNwF

play_round ^hScPAipg

main ^HyhZyPeO

%%
## Drawing
```compressed-json
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
```
%%