# **ImageFeed**

## **Ссылки**

- [Дизайн в Figma](https://tinyurl.com/image-feed-figma)
- [Unsplash API](https://unsplash.com/documentation)
- [Скринкаст готового приложения](https://github.com/UdachiTomo/ImageFeed/assets/118978580/a0ad44a2-45d7-41ed-9374-7f1d97a9d570)

## **Назначение и цели приложения**

Многостраничное приложение предназначено для просмотра изображений через API Unsplash.

Цели приложения:

- Просмотр бесконечной ленты картинок из Unsplash Editorial.
- Просмотр краткой информации из профиля пользователя.

### Краткое описание приложения

- В приложении обязательна авторизация через OAuth Unsplash.
- Главный экран состоит из ленты с изображениями. Пользователь может просматривать ее, добавлять и удалять изображения из избранного.
- Пользователи могут просматривать каждое изображение отдельно и делиться ссылкой на них за пределами приложения.
- У пользователя есть профиль с избранными изображениями и краткой информацией о пользователе.

## **Функциональные требования**

### Авторизация через OAuth

Для входа в приложение пользователь должен авторизоваться через OAuth.

**Экран авторизации содержит:**

1. Логотип приложения
2. Кнопку «Войти»

**Алгоритмы и доступные действия:**

1. При входе в приложение пользователь видит splash-screen;
2. После загрузки приложения открывается экран с возможностью авторизации;
    1. При нажатии на кнопку «Войти» открывается браузер на странице авторизации Unsplash;
        1. При нажатии на кнопку «Login» браузер закрывается. В приложении появляется экран загрузки;
        2. Если авторизация через OAuth Unsplash не настроена, по нажатию на кнопку логина ничего не происходит;
        3. Если авторизация через OAuth Unsplash настроена не корректно — пользователь не сможет войти в приложение;
        4. При неудачной попытке входа всплывает модальное окно с ошибкой;
            1. При нажатии на «ОК» пользователь переходит обратно на экран авторизации;
        5. Если авторизация прошла успешно, то браузер закрывается. В приложении открывается экран с лентой.

### Просмотр ленты

В ленте пользователь может просматривать изображения в ленте, переходить к просмотру отдельного изображения и добавлять их в избранное.

**Экран ленты содержит:**

1. Карточку с изображением;
    1. Кнопку Лайк;
    2. Дату загрузки фотографии;
2. Таб бар для навигации между лентой и профилем.

**Алгоритмы и доступные действия:**

1. Экран с лентой открывается по умолчанию после входа в приложение;
2. Лента содержит изображения из Unsplash Editorial;
3. При скролле вниз и вверх пользователь может просматривать ленту;
    1. Если изображение не успело загрузиться, то пользователю отображается системный лоадер;
    2. Если изображение невозможно загрузить – пользователь видит плэйсхолдер вместо изображения;
4. При нажатии на кнопку Лайк (серое сердечко) пользователь может лайнкуть изображение. После нажатия отображается лоадер:
    1. Если запрос успешный, то лоадер пропадает, иконка меняет состояние на Кнопку Красный Лайк (красное сердечко).
    2. Если запрос не успешный, то всплывает модальное окно с ошибкой «попробуйте еще раз»
5. Пользователь может убрать лайк, повторно нажав на кнопку Лайк (красное сердечко). После нажатия отображается лоадер:
    1. Если запрос успешный, то лоадер пропадает, иконка меняет состояние на серое сердечко.
    2. Если запрос не успешный, то всплывает модальное окно с ошибкой «попробуйте еще раз»;
6. При нажатии на карточку с изображением оно увеличится до границ телефона и пользователь перейдет на экран просмотра изображения (раздел «Просмотр изображения на весь экран»);
7. При нажатии на иконку профиля пользователь может перейти в профиль;
8. Пользователь может переключаться между экранами ленты и профиля с помощью таб бара.

### Просмотр изображения на весь экран

Из ленты пользователь может перейти к просмотру изображения на весь экран и поделиться им.

**Экран содержит:**

1. Увеличенное изображение до границ телефона;
2. Кнопку возврата на предыдущий экран;
3. Кнопку для загрузки изображения и с возможностью им поделиться.

**Алгоритмы и доступные действия:**

1. При открытии изображения на весь экран пользователь видит растянутое изображение до границ экрана. Изображение выровнено по центру;
    1. Если изображение невозможно загрузить и показать – пользователь видит плэйсхолдер;
    2. Если ответ на запрос не получен — появляется системный алерт с ошибкой;
2. При нажатии на кнопку Назад пользователь может вернуться на экран просмотра ленты;
3. При помощи жестов пользователь может перемещаться по растянутому изображению, зумировать и поворачивать изображение. Изображение фиксируется в выбранном положении;
    1. Если не настроены жесты для увеличения или поворота изображения — эти действия будут не доступны;
4. При нажатии на кнопку кнопку Поделиться всплывает системное меню, в котором пользователь может загрузить изображение или поделиться им;
    1. После совершения действия меню скрывается;
    2. Пользователь может закрыть меню свайпом вниз или при нажатии на крестик;
    3. Если открытие системного меню при нажатии на кнопку “загрузить или поделиться изображением” не настроено — оно не будет показываться;

### Просмотр профиля пользователя

Пользователь может перейти в свой профиль, чтобы посмотреть данные профиля или выйти из него.

**Экран профиля содержит:**

1. Данные профиля;
    1. Фотографию пользователя;
    2. Имя и username пользователя;
    3. Информация о себе;
2. Кнопку выхода из профиля;
3. Таб бар;

**Алгоритмы и доступные действия:**

1. Данные профиля загружаются из профиля в Unsplash. Данные профиля нельзя изменить в приложении;
    1. Если данные профиля не подтянулись из Unsplash, то пользователь видит плэйсхолдер вместо аватрки. Username и имя не отображаются;
2. При нажатии на кнопку выхода из профиля (логаут) пользователь может выйти из приложения. Всплывает системный алерт с подтверждением выхода;
    1. Если пользователь нажимает «Да», то он разлогинивается и открывается экран авторизации;
        1. Если не настроены или настроены неправильно действия с кнопкой «Да», то при нажатии пользователя не разлогинивается и попадает на экран авторизации;
    2. Если пользователь нажимает «Нет», то он возвращается на экран профиля;
    3. Если алерт не настроен, то при нажатии на кнопку выхода ничего не происходит, пользователь не может разлогиниться;
3. Пользователь может переключаться между экранами ленты и профиля с помощью таб бара.

## **Технические требования**

1. Авторизация работает через OAuth Unsplash и POST запрос для получения Auth Token.
2. Лента реализована с помощью UITableView.
3. В приложении использованы UImageView, UIButton, UILabel, TabBarController, NavigationController, NavigationBar, UITableView, UITableViewCell.
4. Приложение должно поддерживать устройства iPhone с iOS 13 или выше, предусмотрен только портретный режим.
5. Все шрифты в приложении должны быть выбраны из множества стандартных для платформы (для iOS 13 - это [SF Pro](https://developer.apple.com/fonts/)).
6. Используются внешние зависимости через SPM: Kingfisher, ProgressHUD, SwiftKeychainWrapper.

## **Инструкция по запуску**
Для запуска потребуется [Xcode](https://developer.apple.com/xcode/)
1. Скачайте архив main ветки из github:  
    <img width="908" alt="Снимок экрана 2023-11-19 в 21 20 22" src="https://github.com/UdachiTomo/ImageFeed/assets/118978580/9e86f9fc-3de7-480d-82ba-fb8c0e4d8ef2">
2. Распакуйте архив и запустите проект:  
   2.1 Зайдите в распакованную папку:  
   <img width="925" alt="Снимок экрана 2023-11-19 в 21 25 10" src="https://github.com/UdachiTomo/ImageFeed/assets/118978580/10d9cb04-1551-41fc-a510-11127ba3f47d">
   2.2 Откройте файл *YP-ImageFeed.xcodeproj*:  
3. В Xcode запустите приложение на симуляторе или на реальном устройстве.# ImageFeed
