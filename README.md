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

## Installation
Libraries used here, that we must instal is **SnapKit**. You can download the project from GitHub as a zip file and then open it in the **xCode** application.

## Usage

### Components
#### TextField.swift
Класс `TextField` представляет собой настраиваемый текстовый поле с дополнительной функциональностью, такой как отображение placeholder'а, управление стилем границы, и возможность использования в качестве поля ввода пароля с кнопкой для отображения/скрытия пароля.

##### Свойства:

- `placeholderLabel`: UILabel для отображения placeholder'а.
- `isError`: Флаг, указывающий на наличие ошибки в поле.
- `isPassword`: Флаг, указывающий, является ли поле полем для ввода пароля.
- `showPasswordButton`: Кнопка для отображения/скрытия пароля.

##### Методы:

- `setupTextFieldPlaceholder()`: Настройка UILabel для отображения placeholder'а.
- `setupBorder()`: Настройка стиля границы, включая цвет и положение.
- `setupTextField()`: Общая настройка текстового поля, включая шрифт, цвет текста и, при необходимости, кнопку отображения/скрытия пароля.
- `textFieldDidChange(_:)`: Обработчик изменения текста в поле для анимации отображения/скрытия placeholder'а.
- `textRect(forBounds:)` и `editingRect(forBounds:)`: Переопределенные методы для настройки области текста внутри поля.
---

#### Button.swift
Класс `Button` представляет собой настраиваемую кнопку с возможностью управления активностью (включено/выключено).

##### Свойства:

- `isActive`: Флаг, указывающий, активна ли кнопка.

##### Методы:

- `custumize()`: Настройка внешнего вида кнопки, включая шрифт, цвет фона и активность кнопки.
- `setActive(_:)`: Метод для установки активности кнопки.
---

#### BarButtonItem.swift
Класс `BarButtonItem` представляет собой настраиваемую кнопку для использования в панели навигации.

##### Методы:

- `custumize()`: Настройка внешнего вида кнопки, включая шрифт, цвет фона и отступы.
---

#### ProfileTextField.swift
Класс `ProfileTextField` представляет собой кастомизированное текстовое поле, предназначенное для использования в профиле пользователя.

##### Методы:
- `setupBorder()`: Настройка стиля границы, включая цвет.
- `setupTextFieldPlaceholder()`: Настройка UILabel для отображения placeholder'а.
- `setupTextField()`: Общая настройка текстового поля, включая шрифт и цвет текста.
- `textFieldDidChange(_:)`: Обработчик изменения текста в поле для скрытия/отображения placeholder'а.
- `textRect(forBounds:)` и `editingRect(forBounds:)`: Переопределенные методы для настройки области текста внутри поля.
---

### 1. Регистрация и Авторизация

- **Авторизация:** Пользователи могут зарегистрироваться с помощью логина и адреса электронной почты.

Из-за того что пока не подключен бэкенд используйте это данные:
login: Neobis
Password: neobis2023

- **Регистрация:** Тут пользователи могут зарегистрироваться и установить пароль, после успешной установки опять направляются на страницу авторизации.

### 2. Главная страница

- **Лента товаров:** На главной странице представлена визуально привлекательная лента товаров с важной информацией, такой как цена и краткое описание.
- Нажимая на продукт вы будете направлены на страницу где можете увидеть более подробную иснформацию о продукте.
- **Добавление в избранное:** Пользователи могут добавлять продукты в избранное для легкого доступа. Добавленные в избранное продукты вы можете увидеть на страницу Профиля -> Понравившиеся. 

### 4. Добавление новых товаров

- **Добавление товаров:** Авторизованные пользователи могут добавлять новые товары для расширения и постоянного обновления каталога.

### 5. Профиль пользователя

- **Профиль:** Пользователи могут создавать и управлять своими личными данными в профиле. Если же вы только зарегистрировались вам необходима закочить регистрацию нажав на соответсвующую кнопку. Где вы можете редактировать все данные кроме email, так же подтвердить телефон.
- **Понравившиеся:** Возможность сохранения и просмотра понравившихся товаров.
- **Мои товары:** Пользователи могут редактировать товары, которые они сами добавили.


## Contribution
Contributions to this project are welcome!
You can organize my code, add a new functionalities, user interface improvments,testing, error handling, add Combine, add the back-end. 

Feel free to customize, extend, or modify these components and view controllers according to your project requirements. If you have specific questions about any part of the code or need further assistance, please let us know!

## Author
git: sembaynaz




## Вклад и обратная связь

Мы приветствуем ваши вклады и обратную связь. Если у вас есть предложения или найдены ошибки, пожалуйста, создайте issue или отправьте pull request.
