my_todo/lib/
├── main.dart                    # Dastur kirish nuqtasi
├── app.dart                     # Asosiy app konfiguratsiyasi
├── routes/                      # Routing tizimi
│   ├── app_router.dart         # Asosiy router
│   └── path_router.dart        # Path router
├── core/                        # Asosiy funksionallik
│   ├── constants/              # Konstanta fayllar
│   │   ├── app_colors.dart     # Ranglar
│   │   ├── app_dimens.dart     # O'lchamlar
│   │   ├── app_icons.dart      # Ikonkalar
│   │   ├── app_strings.dart    # Matnlar (bo'sh)
│   │   └── text_style.dart     # Matn stillari
│   ├── error/                  # Xatoliklar (bo'sh)
│   ├── services/               # Xizmatlar
│   │   ├── auth_service.dart   # Autentifikatsiya
│   │   ├── coonectivity_service.dart # Internet aloqasi
│   │   ├── hive_service.dart   # Hive ma'lumotlar bazasi
│   │   ├── local_notification_service.dart # Bildirishnomalar
│   │   └── voice_service.dart  # Ovoz xizmati
│   └── utils/                  # Yordamchi funksiyalar (bo'sh)
├── data/                       # Ma'lumotlar qatlami
│   ├── datasources/            # Ma'lumotlar manbalari
│   │   ├── local/             # Mahalliy ma'lumotlar (bo'sh)
│   │   └── remote/            # Tarmoq ma'lumotlari (bo'sh)
│   ├── models/                # Ma'lumotlar modellari
│   │   └── auth_model.dart    # Autentifikatsiya modeli
│   └── repositories/          # Repository implementatsiyalari (bo'sh)
├── domain/                     # Biznes logika qatlami
│   ├── entities/              # Biznes ob'ektlari
│   │   ├── todo_entity.dart   # Todo ob'ekti
│   │   ├── todo_entity.g.dart # Generated fayl
│   │   └── user_entity.dart   # Foydalanuvchi ob'ekti
│   ├── repositories/          # Repository interfeyslari (bo'sh)
│   └── usecases/              # Biznes logika (bo'sh)
├── presentation/               # Ko'rsatish qatlami
│   ├── pages/                 # Sahifalar
│   │   ├── auth/             # Autentifikatsiya sahifalari
│   │   ├── create_task/      # Vazifa yaratish
│   │   ├── edit_task/        # Vazifa tahrirlash
│   │   ├── home/             # Bosh sahifa
│   │   ├── settings/         # Sozlamalar
│   │   ├── splash/           # Boshlash sahifasi
│   │   └── voice_recorder/   # Ovoz yozish
│   └── widget/               # Widget'lar
│       ├── backround_color.dart # Fon rangi
│       ├── google_button.dart   # Google tugmasi
│       ├── input.dart           # Input maydoni
│       ├── login_button.dart    # Kirish tugmasi
│       └── task_card.dart       # Vazifa karti
├── l10n/                       # Lokalizatsiya
│   ├── app_localizations.dart  # Asosiy lokalizatsiya
│   ├── app_localizations_en.dart # Ingliz tili
│   ├── app_localizations_ru.dart # Rus tili
│   ├── app_localizations_uz.dart # O'zbek tili
│   ├── en.arb                 # Ingliz tili fayli
│   ├── ru.arb                 # Rus tili fayli
│   └── uz.arb                 # O'zbek tili fayli
└── generated/                  # Avtomatik yaratilgan fayllar
├── intl/                  # Intl fayllari
└── l10n.dart              # Lokalizatsiya fayli# my_todo
# my_todo
# my_todo_project
