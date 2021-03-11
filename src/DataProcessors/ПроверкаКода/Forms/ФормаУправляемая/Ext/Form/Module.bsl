﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ЗаполнитьТребования();

	Модули = бпк_ПроверкаКодаСервер.ТипыОбъектовДляПроверки();
	
	Для каждого ЭлементСписка Из Модули Цикл
		Элементы.ТипМодуля.СписокВыбора.Добавить(ЭлементСписка.Значение, ЭлементСписка.Представление);
	КонецЦикла; 
	
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)
	
	УстановитьДоступностьСвойствОбщегоМодуля();

КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	ВыбранныеТребования = Настройки["НастройкиВыбранныхТребований"];
	ОтметитьВыбранныеТребования(Требования.ПолучитьЭлементы(), ВыбранныеТребования);
	
	ИнициализироватьТекстМодуляHTML(ТекстМодуля);

КонецПроцедуры

&НаСервере
Процедура ПриСохраненииДанныхВНастройкахНаСервере(Настройки)
	
	ВыбранныеТребования = Новый Массив;
	ЗаполнитьВыбранныеТребования(Требования.ПолучитьЭлементы(), ВыбранныеТребования, Истина);
	
	Настройки.Вставить("НастройкиВыбранныхТребований", ВыбранныеТребования);
	
	Настройки.Удалить("Требования");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ТребованияПометкаПриИзменении(Элемент)
	
	ТекущиеДанные = Элементы.Требования.ТекущиеДанные;
	ИзменитьРекурсивноПометкиВнизПоИерархии(ТекущиеДанные, ТекущиеДанные.Пометка);
	
	ИзменитьРекурсивноПометкиВверхПоИерархии(ТекущиеДанные, ТекущиеДанные.Пометка);
	
КонецПроцедуры

&НаКлиенте
Процедура ТипМодуляПриИзменении(Элемент)
	
	УстановитьДоступностьСвойствОбщегоМодуля();

КонецПроцедуры

&НаКлиенте
Процедура ОшибкиПриАктивизацииСтроки(Элемент)

	ТекущиеДанные = Элементы.Ошибки.ТекущиеДанные;
	
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ПерейтиКСтрокеРезультатаПоНомеруСтроки(ТекущиеДанные.Номер);

КонецПроцедуры

&НаКлиенте
Процедура ОшибкиПриАктивизацииЯчейки(Элемент)

	Если НЕ Элемент.ТекущийЭлемент.Имя = "ОшибкиСсылка" Тогда 
		Возврат;
	КонецЕсли;	
	ТекущиеДанные = Элементы.Ошибки.ТекущиеДанные;

	ДополнительныеПараметры = Новый Структура;
	ДополнительныеПараметры.Вставить("Ошибка", ТекущиеДанные.Ошибка);	
	ДополнительныеПараметры.Вставить("Правило", ТекущиеДанные.Правило);	
	ДополнительныеПараметры.Вставить("СсылкаНаСтандарт", ТекущиеДанные.СсылкаНаСтандарт);	
	ДополнительныеПараметры.Вставить("Требование", ТекущиеДанные.Требование);	
	
	Список = Новый СписокЗначений;
	
	Если ЗначениеЗаполнено(ТекущиеДанные.СсылкаНаСтандарт) Тогда
		
		Представление = СтрШаблон("Система стандартов на 1С:ИТС > %1", ТекущиеДанные.ОписаниеТребования); 
		
		Список.Добавить("ОткрытьСсылкуНаСтандарт", Представление, , БиблиотекаКартинок.бпк_ИТС);
	КонецЕсли;
	
	Список.Добавить("ПерейтиКПравилу", "Перейти к правилу");
	
	Если ЗначениеЗаполнено(ТекущиеДанные.Требование) Тогда
		Список.Добавить("ПерейтиКТребованию", "Перейти к требованию");
	КонецЕсли;
	
	ОписаниеОповещения = Новый ОписаниеОповещения("ПоказатьВыборИзМенюЗавершение", 
		ЭтотОбъект, ДополнительныеПараметры);
		
	ПоказатьВыборИзМеню(ОписаниеОповещения, Список, Элемент.ТекущийЭлемент);
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СнятьПометки(Команда)
	
	ИзменитьРекурсивноПометкиВнизПоИерархии(Требования, Ложь);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьПометки(Команда)
	
	ИзменитьРекурсивноПометкиВнизПоИерархии(Требования, Истина);
	
КонецПроцедуры

&НаКлиенте
Процедура ВыполнитьПроверкуКода(Команда)
	ТекстМодуля = ПолучитьТекстМодуля();	
	
	Если Не ПроверитьЗаполнение() Тогда
		Возврат;
	КонецЕсли; 
	
	Результат = ВыполнитьПроверкуКодаДлительнойОперацией();
	
	Если НЕ Результат Тогда
		ДлительныеОперацииКлиент.ИнициализироватьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания", 1, Истина);
	Иначе
		ОбработатьРезультатПроверки();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Процедура ИнициализироватьТекстМодуляHTML(ИсполняемыйКод = "")
	
	РаботатьЛокально = Истина; // Если ложь - берем с сайта последние обновления файлов js.
	
	ОбъектСервера = РеквизитФормыВЗначение("Объект");
	
	ТекстHTML = ОбъектСервера.Получитьмакет("index").ПолучитьТекст();
	
	ТекстЗамены = СтрШаблон("<textarea id='code' name='code'>%1</textarea>", ИсполняемыйКод);
	ТекстHTML = СтрЗаменить(ТекстHTML, "<textarea id='code' name='code'></textarea>", ТекстЗамены);
	
	ТекстСтиля = ОбъектСервера.Получитьмакет("lib_codemirror_css").ПолучитьТекст();     
	ТекстЗамены = СтрШаблон("<style>%1</style>", ТекстСтиля);
	
	ТекстHTML = СтрЗаменить(ТекстHTML, 
		"<link rel='stylesheet' href='https://www-1c.ru/wp-content/plugins/codemirror1c/lib/codemirror.css'>", ТекстЗамены);
		
	ТекстСтиля = ОбъектСервера.Получитьмакет("theme_1c_css").ПолучитьТекст();
	ТекстЗамены = СтрШаблон("<style>%1</style>", ТекстСтиля);
	
	ТекстHTML = СтрЗаменить(ТекстHTML, 
		"<link rel='stylesheet' href='https://www-1c.ru/wp-content/plugins/codemirror1c/theme/1c.css'>", ТекстЗамены);
	
	Если РаботатьЛокально Тогда
			
		ТекстСкрипта = ОбъектСервера.Получитьмакет("mode_1c_1c_js").ПолучитьТекст();
		ТекстЗамены = СтрШаблон("<script>%1</script>", ТекстСкрипта);
		ТекстHTML = СтрЗаменить(ТекстHTML, 
			"<script src='https://www-1c.ru/wp-content/plugins/codemirror1c/mode/1c/1c.js'></script>", ТекстЗамены);		
		
		ТекстСкрипта = ОбъектСервера.Получитьмакет("addon_comment_comment_js").ПолучитьТекст();
		ТекстЗамены = СтрШаблон("<script>%1</script>", ТекстСкрипта);
		ТекстHTML = СтрЗаменить(ТекстHTML, 
			"<script src='https://www-1c.ru/wp-content/plugins/codemirror1c/addon/comment/comment.js'></script>", ТекстЗамены);
		
		ТекстСкрипта = ОбъектСервера.Получитьмакет("lib_codemirror_js").ПолучитьТекст();
		ТекстЗамены = СтрШаблон("<script>%1</script>", ТекстСкрипта);
		ТекстHTML = СтрЗаменить(ТекстHTML, 
			"<script src='https://www-1c.ru/wp-content/plugins/codemirror1c/lib/codemirror.js'></script>", ТекстЗамены);	
		
	КонецЕсли;
	
	ТекстМодуляHTML = ТекстHTML;
	
КонецПроцедуры
 
&НаКлиенте
Функция ПолучитьТекстМодуля()
	
	#Если ВебКлиент Тогда
		// Код берется из копии в textarea id=code.
		ИсполняемыйКод = Элементы.ТекстМодуляHTML.Документ.body.ChildNodes[1].innerHTML;
	#Иначе
		ИсполняемыйКод = Элементы.ТекстМодуляHTML.Document.editor.getValue();
	#КонецЕсли	
	
	Возврат ИсполняемыйКод;
	
КонецФункции

&НаСервере
Функция ВыполнитьПроверкуКодаНаСервере()

	ПараметрыПроверки = бпк_ПроверкаКодаСервер.ПараметрыПроверки();	
	ПодготовитьПараметрыПроверки(ПараметрыПроверки);
	
	ПараметрыВыполнения = ДлительныеОперации.ПараметрыВыполненияВФоне(Новый УникальныйИдентификатор);
	ПараметрыВыполнения.НаименованиеФоновогоЗадания = НСтр("ru='Проверка кода: %1'");
	РезультатВыполнения = ДлительныеОперации.ВыполнитьВФоне(
		"бпк_ПроверкаКодаСервер.ПроверитьКод", ПараметрыПроверки, ПараметрыВыполнения);
	
	Возврат РезультатВыполнения;
	
КонецФункции

&НаКлиенте
Функция ВыполнитьПроверкуКодаДлительнойОперацией()
	
	ИдентификаторЗадания = Неопределено;
	ОписаниеОшибки       = "";
	
	ТекстОповещения = НСтр("ru='Начата проверка модуля.'");
	КлючУникальности = Строка(Новый УникальныйИдентификатор);
	ПоказатьОповещениеПользователя(ТекстОповещения, , , , СтатусОповещенияПользователя.Важное, КлючУникальности); 	
	
	РезультатВыполнения = ВыполнитьПроверкуКодаНаСервере();
	
	АдресРезультата = РезультатВыполнения.АдресРезультата;
	
	Если РезультатВыполнения.Статус <> "Выполняется" Тогда
		ИдентификаторЗадания = Неопределено;
		Если РезультатВыполнения.Статус = "Выполнено" Тогда
			ОбработатьРезультатПроверки();
		КонецЕсли;
	Иначе
		ИдентификаторЗадания = РезультатВыполнения.ИдентификаторЗадания;
	КонецЕсли;
	
	Возврат РезультатВыполнения.Статус <> "Выполняется";
	
КонецФункции

&НаКлиенте
Процедура Подключаемый_ПроверитьВыполнениеЗадания()
	
	Если НЕ ЗначениеЗаполнено(ИдентификаторЗадания) Тогда
		Возврат;
	КонецЕсли;
	
	Если ЗаданиеВыполнено() Тогда
		
		ИдентификаторЗадания = Неопределено;
		ОбработатьРезультатПроверки();
		
	Иначе
		ДлительныеОперацииКлиент.ОбновитьПараметрыОбработчикаОжидания(ПараметрыОбработчикаОжидания);
		ПодключитьОбработчикОжидания("Подключаемый_ПроверитьВыполнениеЗадания",
			ПараметрыОбработчикаОжидания.ТекущийИнтервал, Истина);
	КонецЕсли;
	
КонецПроцедуры

&НаСервере
Функция ЗаданиеВыполнено()

	Возврат ДлительныеОперации.ЗаданиеВыполнено(ИдентификаторЗадания);

КонецФункции

&НаКлиенте
Процедура ОбработатьРезультатПроверки()
	
	Результат = ПолучитьИзВременногоХранилища(АдресРезультата);
	
	КоличествоЗамечаний = Результат.КоличествоОшибок;
	
	ТекстПояснения = "Замечаний нет."; 

	Если Не КоличествоЗамечаний = 0 Тогда
		ТекстПояснения = СтрШаблон("Найдено замечаний: %1.", КоличествоЗамечаний); 
	КонецЕсли;
	
	СформироватьТаблицуНавигации(Результат.Ошибки);
	
	ТекстОповещения = НСтр("ru='Проверка модуля завершена.'");
	КлючУникальности = Строка(Новый УникальныйИдентификатор);
	
	ПоказатьОповещениеПользователя(ТекстОповещения, , ТекстПояснения, , СтатусОповещенияПользователя.Важное,
		КлючУникальности); 	
	
КонецПроцедуры

&НаСервере
Процедура СформироватьТаблицуНавигации(НайденныеОшибки)

	Ошибки.Очистить();

	Для каждого НайденнаяОшибка Из НайденныеОшибки Цикл
	
		НоваяСтрока = Ошибки.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, НайденнаяОшибка);
		
		ОписаниеОшибки = бпк_ПроверкаКодаПовтИсп.ПолучитьОписаниеОшибки(НайденнаяОшибка.Ошибка);
		ЗаполнитьЗначенияСвойств(НоваяСтрока, ОписаниеОшибки);
		
		МестоОбнаружения = СтрЗаменить(НайденнаяОшибка.МестоОбнаружения, "Модуль, ", "");
		
		НоваяСтрока.Описание = СтрШаблон("%1, %2", МестоОбнаружения, НайденнаяОшибка.Ошибка.Наименование);
	
	КонецЦикла; 

	Ошибки.Сортировать("Номер");
	
КонецПроцедуры

&НаСервере
Процедура ПодготовитьПараметрыПроверки(ПараметрыПроверки)
	
	ВыбранныеТребования = Новый Массив;
	
	ТекущиеЭлементы = Требования.ПолучитьЭлементы();	
	ЗаполнитьВыбранныеТребования(ТекущиеЭлементы, ВыбранныеТребования);
	
	ПараметрыПроверки.Вставить("ТипОбъекта", ТипМодуля);
	ПараметрыПроверки.Вставить("Требования", ВыбранныеТребования);
	ПараметрыПроверки.Вставить("ТекстМодуля", ТекстМодуля);
	
	СвойстваМодуля = Новый Структура;
	
	Если ТипМодуля = Перечисления.ТипыОбъектов.ОбщийМодуль Тогда
		СвойстваМодуля.Вставить("Сервер", Сервер);
		СвойстваМодуля.Вставить("КлиентОбычноеПриложение", КлиентОбычноеПриложение);
		СвойстваМодуля.Вставить("КлиентУправляемоеПриложение", КлиентУправляемоеПриложение);
		СвойстваМодуля.Вставить("ВнешнееСоединение", ВнешнееСоединение);
	КонецЕсли; 
	
	ПараметрыПроверки.Вставить("Свойства", СвойстваМодуля);
	
КонецПроцедуры

&НаКлиенте
Процедура УстановитьДоступностьСвойствОбщегоМодуля()

	Элементы.ГруппаСвойстваОбщегоМодуля.ТолькоПросмотр = 
			Не (ТипМодуля = ПредопределенноеЗначение("Перечисление.ТипыОбъектов.ОбщийМодуль"));

КонецПроцедуры

// Помечает элементы вниз по иерархии
//
&НаКлиенте
Процедура ИзменитьРекурсивноПометкиВнизПоИерархии(ДанныеФормы, Пометка)
	
	ЭлементыДерева = ДанныеФормы.ПолучитьЭлементы();

	Для каждого ЭлементДерева Из ЭлементыДерева Цикл
		ЭлементДерева.Пометка = Пометка;	
	    ИзменитьРекурсивноПометкиВнизПоИерархии(ЭлементДерева, Пометка);
	КонецЦикла; 		

КонецПроцедуры // РекурсивноВнизСнятьУстановитьПометки

// Помечает элементы вверх по иерархии
//
&НаКлиенте
Процедура ИзменитьРекурсивноПометкиВверхПоИерархии(ЭлементДерева, Пометка)
	
	ЭлементДереваРодитель = ЭлементДерева.ПолучитьРодителя();
	
	Если НЕ ЭлементДереваРодитель = Неопределено Тогда
		
		Если Пометка Тогда
			ЭлементДереваРодитель.Пометка = Пометка;	
		Иначе
			ЕстьПометкаПодчиненныхЭлементов = Ложь;
			ПодчиненныеЭлементыРодителя = ЭлементДереваРодитель.ПолучитьЭлементы();	
			Для каждого ПодчиненныйЭлементРодителя Из ПодчиненныеЭлементыРодителя Цикл
				
				Если ПодчиненныйЭлементРодителя.Пометка Тогда
					ЕстьПометкаПодчиненныхЭлементов = Истина;
				КонецЕсли; 
			
			КонецЦикла; 
			
			ЭлементДереваРодитель.Пометка = ЕстьПометкаПодчиненныхЭлементов;	
			
		КонецЕсли;
		
		ИзменитьРекурсивноПометкиВверхПоИерархии(ЭлементДереваРодитель, Пометка);
	КонецЕсли; 

КонецПроцедуры // РекурсивноВверхСнятьУстановитьПометки

// Функция возвращает таблицу требований для заданной конфигурации и варианта проверки.
//
&НаСервере
Процедура ЗаполнитьТребования()
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	Требования.Ссылка КАК Требование,
		|	Требования.Родитель КАК Родитель,
		|	Требования.ЭтоГруппа КАК ЭтоГруппа,
		|	ВЫБОР
		|		КОГДА Требования.ЭтоГруппа
		|			ТОГДА 1
		|		ИНАЧЕ 2
		|	КОНЕЦ КАК ИндексКартинки
		|ИЗ
		|	Справочник.Требования КАК Требования
		|ИТОГИ
		|	МИНИМУМ(ИндексКартинки)
		|ПО
		|	Требование ИЕРАРХИЯ";
	
	Результат = Запрос.Выполнить().Выгрузить(ОбходРезультатаЗапроса.ПоГруппировкамСИерархией);
	
	ТекущиеЭлементы = Требования.ПолучитьЭлементы();
	ДобавитьВетвьВДерево(Результат.Строки, ТекущиеЭлементы);
	
КонецПроцедуры

&НаСервере
Процедура ДобавитьВетвьВДерево(СтрокиДерева, ТекущиеЭлементы)

	Для каждого СтрокаДерева Из СтрокиДерева Цикл
		
		Если НЕ СтрокаДерева.Родитель = Неопределено И СтрокаДерева.Требование = СтрокаДерева.Родитель.Требование Тогда
			Продолжить;
		КонецЕсли; 
		
		НовыйЭлемент = ТекущиеЭлементы.Добавить();
		ЗаполнитьЗначенияСвойств(НовыйЭлемент, СтрокаДерева);
		ДобавитьВетвьВДерево(СтрокаДерева.Строки, НовыйЭлемент.ПолучитьЭлементы());
	
	КонецЦикла; 

КонецПроцедуры

&НаСервере
Процедура ОтметитьВыбранныеТребования(ТекущиеЭлементы, ВыбранныеТребования)
	
	Для каждого ЭлементДерева Из ТекущиеЭлементы Цикл
		
		Если Не ВыбранныеТребования = Неопределено 
			И Не ВыбранныеТребования.Найти(ЭлементДерева.Требование) = Неопределено Тогда
			ЭлементДерева.Пометка = Истина;
		КонецЕсли;	
		
		Если ЭлементДерева.ЭтоГруппа Тогда
			ОтметитьВыбранныеТребования(ЭлементДерева.ПолучитьЭлементы(), ВыбранныеТребования);
		КонецЕсли;
		
	КонецЦикла; 
	
КонецПроцедуры

&НаСервере
Процедура ЗаполнитьВыбранныеТребования(ТекущиеЭлементы, ВыбранныеТребования, ВключаяГруппы = Ложь)

	Для каждого ЭлементДерева Из ТекущиеЭлементы Цикл
		Если Не ЭлементДерева.Пометка Тогда
			Продолжить;
		КонецЕсли;	
		
		Если Не ЭлементДерева.ЭтоГруппа Тогда
			ВыбранныеТребования.Добавить(ЭлементДерева.Требование);
		Иначе
			
			Если ВключаяГруппы Тогда
				ВыбранныеТребования.Добавить(ЭлементДерева.Требование);
			КонецЕсли; 
			
			ЗаполнитьВыбранныеТребования(ЭлементДерева.ПолучитьЭлементы(), ВыбранныеТребования, ВключаяГруппы);
		КонецЕсли;	
		
	КонецЦикла; 

КонецПроцедуры

&НаКлиенте
Процедура ПерейтиКСтрокеРезультатаПоНомеруСтроки(НомерСтроки)

	// TO DO Переход к строке
	
КонецПроцедуры
				
&НаКлиенте
Процедура ПоказатьВыборИзМенюЗавершение(Результат, ДополнительныеПараметры = Неопределено) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли; 
	
	Если Результат.Значение = "ОткрытьСсылкуНаСтандарт" Тогда
		
		ЗапуститьПриложение(ДополнительныеПараметры.СсылкаНаСтандарт);
		
	ИначеЕсли Результат.Значение = "ПерейтиКПравилу" Тогда
		
		ПоказатьЗначение(, ДополнительныеПараметры.Правило);
		
	ИначеЕсли Результат.Значение = "ПерейтиКТребованию" Тогда
		
		ПоказатьЗначение(, ДополнительныеПараметры.Требование);
		
	Иначе
		Возврат;
	КонецЕсли; 
	
КонецПроцедуры

#КонецОбласти
