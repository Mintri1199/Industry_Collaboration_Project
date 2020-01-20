# Kabegami  

![alt text](https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/readmeicon.png)

An iOS application that let's the user generate a picture with their personal goals on it for their lock screen background.

[TEST FLIGHT](https://testflight.apple.com/join/zNGYLyia)

### Prerequisites

This project does use some pods so make sure to have CocoaPods installed.
How to check
```
pod --version
```
if command not found it mean you didn't installed

How to install CocoaPods
```
sudo gem install cocoapods
```
CocoaPods [reference](https://cocoapods.org/)

### Installing
Clone the project

```
git clone https://github.com/Mintri1199/Industry_Collaboration_Project.git
```

Install project pods

```
pod install
```

### Screenshots
| Onboarding            | Home Screen             | Create Goal             |
| :-------------------: |:-----------------------:| :----------------------:|
| ![alt text][onboard]  | ![alt text][homeScreen] | ![alt text][createGoal] |

| Home Screen with goals      | View Goal               | Wallpaper Screen        |
| :-------------------------: |:-----------------------:| :----------------------:|
| ![alt text][newHomeScreen]  | ![alt text][viewGoal]   | ![alt text][imgConfig]  |

| Configured Wallpaper Screen | Image Preview Screen    | Editing Image           |
| :-------------------------: |:-----------------------:| :----------------------:|
| ![alt text][imgConfigured]  | ![alt text][imgPreview] | ![alt text][imgEdit]    |

[onboard]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/onboarding.png
[homeScreen]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/homeScreen.png
[createGoal]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/createGoal.png
[newHomeScreen]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/updateHomeScreen.png
[viewGoal]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/updateGoal.png
[imgConfig]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/imageConfiguration.png
[imgConfigured]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/imageSelectino.png
[imgPreview]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/preview.png
[imgEdit]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/img/editImage.png

##### Dependencies

* [SwiftLint][linter] - The linter used to enforce code quality
  * YAML file from [Lickability][yml]
* [ToCropViewController][cropVC] - A picture cropping view controller library


[cropVC]: https://github.com/TimOliver/TOCropViewController

[linter]: https://github.com/realm/SwiftLint

[yml]: https://github.com/Lickability/swift-best-practices/blob/master/.swiftlint.yml

## Contributors

* **Jackson Ho** - [Github](https://github.com/Mintri1199)
* **Stephen Ouyang** - [Github](https://github.com/Xisouyang)
* **Jamar Gibbs** - [Github](https://github.com/j-n4m4573)

See also the list of [contributors](https://github.com/Mintri1199/Industry_Collaboration_Project/graphs/contributors) who participated in this project.

## License

This project is licensed under the GNU GPLv3 License - see the [license.txt][license] file for details

[license]: https://github.com/Mintri1199/Industry_Collaboration_Project/blob/master/license.txt

## Current Features

- [x] User can Create/Read/Update/Delete goals

- [x] Implemented Core Data

- [x] User can move goals when editing picture

- [x] User can generate a picture with up to 4 goals

- [x] User can save generated picture to their photo library

- [x] User can preview their generated picture before saving it

## Future features

- [ ] UnSplash API integration (WIP)

- [ ] More representation of goals ie. progress bars

- [ ] Enable milestones for goals (WIP)

- [ ] Picture cropping feature (WIP)
