# iOS_Market

<img width = "123" height = "250" src = "https://github.com/sembaynaz/iOS_Market/assets/96616194/d37dea02-99cd-4173-ade8-4b7ffb6a43e9">
<img width = "123" height = "250" src = "https://github.com/sembaynaz/iOS_Market/assets/96616194/db20714c-51f7-4ace-baa6-fbd933656971">
<img width = "123" height = "250" src = "https://github.com/sembaynaz/iOS_Market/assets/96616194/be8a36fb-ca1e-477e-884b-4dfd9d431463">
<img width = "123" height = "250" src = "https://github.com/sembaynaz/iOS_Market/assets/96616194/74ecf744-3d0b-4971-bc2a-d3a233b229a0">
<img width = "123" height = "250" src = "https://github.com/sembaynaz/iOS_Market/assets/96616194/efa8ff46-a809-4929-9f93-b14887ef0de4">
<img width = "123" height = "250" src = "https://github.com/sembaynaz/iOS_Market/assets/96616194/50837e3c-0f2f-4493-b9e0-6b95cb5e3747">
<img width = "123" height = "250" src = "https://github.com/sembaynaz/iOS_Market/assets/96616194/76740c11-a027-4013-a456-7c189e394e6a">

## Project Description

This project is designed to provide users with a convenient and intuitive experience in viewing and purchasing goods. Including a user profile feature that allows you to manage personal information and increases security through phone number verification.

**Login:** Neobis
**Password:** neobis2023


## Installation
Libraries used here, that we must instal is **SnapKit**. You can download the project from GitHub as a zip file and then open it in the **xCode** application.

## Usage
## Оглавление
1. [Components](#Components)
   - [TextField](#TextField.swift)
   - [Button](#Button.swift)
   - [BarButtonItem](#BarButtonItem.swif)
   - [ProfileTextField](ProfileTextField.swif)
2. [ViewControllers](#ViewControllers)
   - [Registration and Authorization](#Registration-and-Authorization)
   - [TabBarViewController](#TabBarViewController.swift)
   - [Home Page](#Home-Page)
   - [Adding New Products](Adding-New-Products)
   - [User Profile](#User-Profile)
   - [AlertViewController](#AlertViewController)

# Components
### TextField.swift
The `TextField` class represents a customizable text field with additional functionality, such as displaying a placeholder, managing border style, and the ability to use it as a password input field with a button for showing/hiding the password.

#### Properties:

- `placeholderLabel`: UILabel for displaying the placeholder.
- `isError`: A flag indicating the presence of an error in the field.
- `isPassword`: A flag indicating whether the field is a password input field.
- `showPasswordButton`: Button for showing/hiding the password.

#### Methods:

- `setupTextFieldPlaceholder()`: Configures the UILabel for displaying the placeholder.
- `setupBorder()`: Configures the border style, including color and position.
- `setupTextField()`: General setup of the text field, including font, text color, and, if needed, a button for showing/hiding the password.
- `textFieldDidChange(_:)`: Text change handler for animating the display/hiding of the placeholder.
- `textRect(forBounds:)` and `editingRect(forBounds:)`: Overridden methods for configuring the text area inside the field.
---

### Button.swift
The `Button` class represents a customizable button with the ability to control its activity (enabled/disabled).

#### Properties:

- `isActive`: A flag indicating whether the button is active.

#### Methods:

- `customize()`: Configures the appearance of the button, including font, background color, and button activity.
- `setActive(_:)`: Method for setting the button's activity.
---

### BarButtonItem.swift
The `BarButtonItem` class represents a customizable button for use in the navigation bar.

#### Methods:

- `customize()`: Configures the appearance of the button, including font, background color, and margins.
---

### ProfileTextField.swift
The `ProfileTextField` class represents a customized text field intended for use in the user profile.

#### Methods:

- `setupBorder()`: Configures the border style, including color.
- `setupTextFieldPlaceholder()`: Configures the UILabel for displaying the placeholder.
- `setupTextField()`: General setup of the text field, including font and text color.
- `textFieldDidChange(_:)`: Text change handler for hiding/displaying the placeholder.
- `textRect(forBounds:)` and `editingRect(forBounds:)`: Overridden methods for configuring the text area inside the field.
---

# ViewControllers

## Registration and Authorization

- **Authorization:** Users can register using their login and email address.

Since the backend is not connected yet, use the following test data:
Login: Neobis
Password: neobis2023

- **Registration:** Here users can register and set a password, after successful registration, they are redirected to the authorization page.
---

## TabBarViewController.swift

The `TabBarViewController` class represents a tab bar controller for organizing the main navigation flow in the application. It also includes a customized tab bar (`TabBar`), which includes a central button for adding a product.

#### Methods:

- `generateTabBar()`: Creates and configures view controllers for the tab bar, including tabs for "Home," "Wallet," "Chats," "Profile," and a central tab for adding a product.
- `generateVC(viewController:title:image:tag:isEnabled:)`: Helper method for creating a view controller instance for the tab bar with specified parameters.
- `setTabBarHeight(height:)`: Method for setting the height of the tab bar.
- `plusButtonTapped()`: Handler for pressing the "Plus" button (adding a product), opening the corresponding screen.
---

## TabBar.swift

The `TabBar` class represents a customized tab bar for use on the main screen of the application. It includes a central button (plus) and customizable styles, colors, and shadows.

#### Properties:

- `middleButton`: Button located in the center of the tab bar with the "Plus" image.
- `makeUI()`: Configures the interface of the tab bar, including the background, central button, and overall style.
- `setTabBarAppearance()`: Configures the overall appearance of the tab bar, including colors and transparency.
- `dropShadow(scale:)`: Adds a shadow to the tab bar with specified parameters.
---

## Home Page

- **Product Feed:** The main page features a visually appealing product feed with important information such as price and a brief description.
- By clicking on a product, you will be directed to a page where you can see more detailed information about the product.
- **Add to Favorites:** Users can add products to their favorites for easy access. Added favorite products can be viewed on the Profile page -> Likes.
---

## Adding New Products

- **Add Products:** Authenticated users can add new products to expand and continuously update the product catalog.
---

## User Profile

- **Profile:** Users can create and manage their personal data on the profile page. If you have just registered, you need to complete the registration by clicking on the corresponding button. Here, you can edit all data except for email and verify your phone.
- **Likes:** The ability to save and view liked products.
- **My Products:** Users can edit the products they added themselves.
---

## AlertViewController
- The AlertView and AlertViewController combination allows for the creation of customizable alerts with different messages, images, and button titles.
- The AlertDelegate protocol provides a way for the alert to communicate with the presenting view controller when the user taps the agree button.

---
## Contribution
Contributions to this project are welcome!
You can organize my code, add a new functionalities, user interface improvments,testing, error handling, add Combine, add the back-end. 

Feel free to customize, extend, or modify these components and view controllers according to your project requirements. If you have specific questions about any part of the code or need further assistance, please let us know!

## Author
git: sembaynaz

e-mail: nazerke.sembay11@gmail.com 

telegram: @sembaynaz
