//
//  TaskDescription.swift
//  MyGitHubAPI
//
//  Created by macuser on 11/29/22.
//

import Foundation

/*
 Task description:
 
 Тестовое задание: необходимо написать приложение под платформу iOS,
 позволяющее просматривать список всех публичных репозиториев с сервиса GitHub,
 а также детальную информацию по любому из них.

 Требования к приложению:
 1) Язык - Swift;
 2) Минимальная поддерживаемая версия ОС - iOS 10.0;

 Требования к функционалу приложения:
 1) Отображение списка всех публичных репозиториев, размещённых на GitHub.
 Ознакомится с документацией нужного метода можно по адресу
 https://docs.github.com/en/rest/repos/repos#list-public-repositories
 2) Поддержка пагинации в списке репозиториев;
 3) Возможность обновления списка с помощью pull-to-refresh;
 4) Каждый элемент списка должен содержать следующую информацию:

 4.1) Идентификатор (id);

 4.2) Название (name);

 4.3) Имя владельца (owner.login);

 4.4) Описание (description);
 Расположение этих составляющих остаётся на усмотрение разработчика,
 необходимо просто аккуратно сверстать элемент списка;
 5) По клику на элемент списка должна открываться страница с детальной
 информацией о репозитории;
 6) На детальной странице необходимо отобразить web-страницу репозитория;
 7) Возможность поделиться ссылкой на страницу репозитория с помощью
 стандартного диалога шаринга.

 Будет плюсом:

 1) Использование одного из следующих паттернов проектирования: MVP, MVVM,
 VIPER;

 2) Проектирование архитектуры согласно принципам SOLID;

 Нет ограничения на используемые библиотеки. Важно только то, чтобы их
 использование было обосновано. К примеру, использование Alamofire/Moya для
 загрузки данных из сети.
 
 */
