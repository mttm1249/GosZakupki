//
//  ListModel.swift
//  GZ
//
//  Created by Денис on 05.05.2022.
//

import Foundation

class ListModel {
    let array = ["01 - Продукция и услуги сельского хозяйства и охоты",
                     "02 - Продукция лесоводства, лесозаготовок и связанные с этим услуги",
                     "03 - Рыба и прочая продукция рыболовства и рыбоводства; услуги, связанные с рыболовством и рыбоводством",
                     "05 - Уголь",
                     "06 - Нефть и газ природный (в ред. Изменения 39/2019 ОКПД 2, утв. Приказом Росстандарта от 14.11.2019 N 1145-ст)",
                     "07 - Руды металлические",
                     "08 - Продукция горнодобывающих производств прочая",
                     "09 - Услуги в области добычи полезных ископаемых",
                     "10 - Продукты пищевые",
                     "11 - Напитки",
                     "12 - Изделия табачные",
                     "13 - Текстиль и изделия текстильные",
                     "14 - Одежда",
                     "15 - Кожа и изделия из кожи",
                     "16 - Древесина и изделия из дерева и пробки, кроме мебели; изделия из соломки и материалов для плетения",
                     "17 - Бумага и изделия из бумаги",
                     "18 - Услуги печатные и услуги по копированию звуко- и видеозаписей, а также программных средств",
                     "19 - Кокс и нефтепродукты",
                     "20 - Вещества химические и продукты химические",
                     "21 - Средства лекарственные и материалы, применяемые в медицинских целях",
                     "22 - Изделия резиновые и пластмассовые",
                     "23 - Продукты минеральные неметаллические прочие",
                     "24 - Металлы основные",
                     "25 - Изделия металлические готовые, кроме машин и оборудования",
                     "26 - Оборудование компьютерное, электронное и оптическое",
                     "27 - Оборудование электрическое",
                     "28 - Машины и оборудование, не включенные в другие группировки",
                     "29 - Средства автотранспортные, прицепы и полуприцепы",
                     "30 - Средства транспортные и оборудование, прочие",
                     "31 - Мебель",
                     "32 - Изделия готовые прочие",
                     "33 - Услуги по ремонту и монтажу машин и оборудования",
                     "35 - Электроэнергия, газ, пар и кондиционирование воздуха",
                     "36 - Вода природная; услуги по очистке воды и водоснабжению",
                     "37 - Услуги по водоотведению; шлам сточных вод",
                     "38 - Услуги по сбору, обработке и удалению отходов; услуги по утилизации отходов",
                     "39 - Услуги по рекультивации и прочие услуги по утилизации отходов",
                     "41 - Здания и работы по возведению зданий",
                     "42 - Сооружения и строительные работы в области гражданского строительства",
                     "43 - Работы строительные специализированные",
                     "45 - Услуги по оптовой и розничной торговле и услуги по ремонту автотранспортных средств и мотоциклов",
                     "46 - Услуги по оптовой торговле, кроме оптовой торговли автотранспортными средствами и мотоциклами",
                     "47 - Услуги по розничной торговле, кроме розничной торговли автотранспортными средствами и мотоциклами",
                     "49 - Услуги сухопутного и трубопроводного транспорта",
                     "50 - Услуги водного транспорта",
                     "51 - Услуги воздушного и космического транспорта",
                     "52 - Услуги по складированию и вспомогательные транспортные услуги",
                     "53 - Услуги почтовой связи и услуги курьерские",
                     "55 - Услуги по предоставлению мест для временного проживания",
                     "56 - Услуги общественного питания",
                     "58 - Услуги издательские",
                     "59 - Услуги по производству кинофильмов, видеофильмов и телевизионных программ, звукозаписей и изданию музыкальных записей",
                     "60 - Услуги в области теле- и радиовещания",
                     "61 - Услуги телекоммуникационные",
                     "62 - Продукты программные и услуги по разработке программного обеспечения; консультационные и аналогичные услуги в области информационных технологий",
                     "63 - Услуги в области информационных технологий",
                     "64 - Услуги финансовые, кроме услуг по страхованию и пенсионному обеспечению",
                     "65 - Услуги по страхованию, перестрахованию и негосударственному пенсионному обеспечению, кроме обязательного социального обеспечения",
                     "66 - Услуги вспомогательные, связанные с услугами финансового посредничества и страхования",
                     "68 - Услуги по операциям с недвижимым имуществом",
                     "69 - Услуги юридические и бухгалтерские",
                     "70 - Услуги головных офисов; услуги консультативные в области управления предприятием",
                     "71 - Услуги в области архитектуры и инженерно-технического проектирования, технических испытаний, исследований и анализа",
                     "72 - Услуги и работы, связанные с научными исследованиями и экспериментальными разработками Эта группировка не включает: - услуги по исследованию конъюнктуры рынка, см. 73.20.11",
                     "73 - Услуги рекламные и услуги по исследованию конъюнктуры рынка",
                     "74 - Услуги профессиональные, научные и технические, прочие",
                     "75 - Услуги ветеринарные",
                     "77 - Услуги по аренде и лизингу Эта группировка не включает: - услуги по финансовому лизингу, см. 64.91.10",
                     "78 - Услуги по трудоустройству и подбору персонала",
                     "79 - Услуги туристических агентств, туроператоров и прочие услуги по бронированию и сопутствующие им услуги",
                     "80 - Услуги по обеспечению безопасности и проведению расследований",
                     "81 - Услуги по обслуживанию зданий и территорий",
                     "82 - Услуги в области административного, хозяйственного и прочего вспомогательного обслуживания",
                     "84 - Услуги в области государственного управления и обеспечения военной безопасности, услуги в области обязательного социального обеспечения",
                     "85 - Услуги в области образования Эта группировка также включает: - специальное обучение учеников, страдающих физическими или психическими недостатками, на каждом уровне образования",
                     "86 - Услуги в области здравоохранения",
                     "87 - Услуги по предоставлению ухода с обеспечением проживания",
                     "88 - Услуги социальные без обеспечения проживания",
                     "90 - Услуги в области творчества, искусства и развлечений",
                     "91 - Услуги библиотек, архивов, музеев и прочие услуги в области культуры",
                     "92 - Услуги по организации и проведению азартных игр и заключению пари, лотерей",
                     "93 - Услуги, связанные со спортом, и услуги по организации развлечений и отдыха",
                     "94 - Услуги общественных организаций",
                     "95 - Услуги по ремонту компьютеров, предметов личного потребления и бытовых товаров",
                     "96 - Услуги персональные прочие",
                     "97 - Услуги домашних хозяйств с наемными работниками",
                     "98 - Продукция и различные услуги частных домашних хозяйств для собственных нужд",
                     "99 - Услуги, предоставляемые экстерриториальными организациями и органами"
    ]
}
  

