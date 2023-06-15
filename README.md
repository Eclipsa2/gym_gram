# Gym Gram

Gym Gram is a gym tracking app developed with Dart and Flutter, designed to help users track their workouts and sets efficiently. With seamless integration with Firebase database, this app provides a reliable platform for fitness enthusiasts to monitor their progress, record exercise routines, and maintain comprehensive fitness logs.

## Contributors:
[Dumitrache Flavian] (https://github.com/flaviiG)
[Ilie Andrei-Virgil](https://github.com/Eclipsa2)
[Sincarenco Nichita](https://github.com/snichita817)

## Features
* **Workout Tracking:** Create workout routines with exercises, sets, repetitions and weights. Easily monitor progress and stay motivated towards your fitness goals.
* **Set Tracking:** Track specific sets within your workout routines. Record details such as repetitions performed, and weights used for accurate progress tracking and performance evaluation.
* **Exercise Library:** Browse and choose from a comprehensive exercise library categorized by muscle group. Easily add exercises to your workout routine.
* **Personalized Profiles:** Customize your profile with profile pictures, bio, and other relevant information.
* **Analytics and Insights:** Track your workout history, progress trends, and performance metrics to identify strengths and areas for improvement.
* **Cloud-Based Syncing:** Gym Gram seamlessly synchronizes your data across multiple devices using Firebase database technology. Access your workout logs, routines, and progress from any device with the app installed, providing convenience and flexibility.

## Installation
1. Clone the repository:  
 ```bash
 git clone https://github.com/Eclipsa2/gym_gram.git
 ```
2. Navigate to the project directory
3. Ensure that you have a code editor and emulator installed on your machine.
4. Make sure the emulator is running before running the app.
5. Install the required dependencies by running the following command in the terminal within the directory of the project:
```bash 
flutter pub get
```
6. Run the app by executing the following command in the terminal:
```bash
flutter run
```
Please make sure you have Flutter and Dart SDK installed as well.

Note: If you prefer to use a physical device for testing, ensure that USB debugging is enabled on your device and it is connected to your machine via USB.

If you encounter any issues during the installation process, refer to the official documentation of Flutter and Android Studio for troubleshooting steps.

## User stories
Our team has come up with 10 user stories:
1. **Pierre, 20:** I'm a student and with so much work to do I keep losing track of my gym progress. I wish I could just log my progress so I won't forget where I'm at with my gym journey because I'm too busy studying.
2. **Virgil, 22, works at Flanco:** I finally feel satisfied with my body and that I can finally show it and be proud about my improvement. I wish there was an app where I can share my glowup with my friends and see theirs too so I can have more motivation.
3. **Nichita, 18:** I'm a gym newbie and I don't have any friends with any fitness knowledge and the online advices aren't trustworthy. I wish I could see some real-time workout routines from people with a good phisique and save them so I can always do them when I go to the gym.
4. **Scovearga, 45, CEO @ Luca:** I'm a fitness enjoyer with 3 years experience. I get a lot of questions about my workout rutines, how I got in shape etc. I wish I could just share my routine with my close friends instead of replying to all of them individually. I am a busy person after all.
5. **Mihnea, 60, elder:** The days I was writing my progress in a journal are long gone. Technology is a part of us, nowadays, thus having an app to save my workouts and PRs is now a must have in every gym rats arsenal of tools. A simple UI, that everyone can get the hang of it, even old guys such as me could use, would be a perfect fit.
6. **Andreea, 36, engineer:** I work at a job which requires minimum physical activity, so in the last few years I put some weight. I would love a gym app which could keep me motivated, by viewing other people transformation stories and progress.
7. **Adrian, 24, personal trainer:** I am a personal trainer and an app in which I could be creating exact workouts I can send to my clients for the days I can’t be training them would be perfect. Also it would be way more easier for my online clients to just send them a photo of the whole workout with exact weights and number of reps rather than writing them huge messages.
8. **Andra, 20, student:** I would want to hit the gym but I have no idea what workouts I should be doing and I am a broke college student so I can’t afford a personal trainer. An app that offers workouts as inspiration for what I should be doing in the gym is a really cool idea.
9. **Flavian, 33, dad of two:** As a busy working parent, I want to be able to access quick and effective workout routines that I can do at home or on-the-go, so that I can maintain my fitness despite my busy schedule.
10. **Florian, 26, athlete:** I want to be able to track my progress and see how I'm performing compared to others in my sport, so that I can stay motivated and continue to improve my performance.

## Backlog
Trello was utilized as the project management tool for organizing and managing the backlog. You can view it by following this [link](https://trello.com/b/ywzcNM8o/progres).

## Use Case Diagram
![here](https://github.com/Eclipsa2/gym_gram/assets/89789148/b4d2fe3c-8123-429b-8c7b-9b2e211f70c4)

## UML Diagram
![UML Diagram drawio](https://github.com/Eclipsa2/gym_gram/assets/89789148/d2d10f6d-a16e-4f00-a5d0-a69933012eda)

## Bug reporting
Our team has encountered the following bugs:
1. At the start of the development, we oversaw the fact that the normal keyboard would appear when adding the weight number or set number. Fixed issue by only showing the numpad keyboard. To see the full issue click [here](https://github.com/Eclipsa2/gym_gram/issues/1).
2. The moment when you were adding a new workout, its number would not increase. The problem was with the get function, where it only took the number of workouts once, and would never update it. To see the full issue click [here](https://github.com/Eclipsa2/gym_gram/issues/2).

## Acknowledgements
Gym Gram makes use of the following open-source libraries and frameworks:
* **[Flutter](https://flutter.dev)**
* **[Firebase](https://firebase.google.com)**  

In a lighthearted tone, we playfully acknowledge our affection for AI in the documentation, proudly mentioning its involvement not only in our development process, when fixing some bugs (like screen flickering on login and register), but also in crafting a small portion of our captivating user stories. Our love for AI knows no bounds!
