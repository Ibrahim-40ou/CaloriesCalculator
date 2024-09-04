import 'package:get/get.dart';

class MyTranslations implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'welcome,': 'مرحباً,',
          'sign in to continue': 'تسجيل الدخول للاستمرار',
          'register': 'انشاء حساب',
          'email': 'البريد الالكتروني',
          'password': 'كلمة المرور',
          'forgot password?': 'نسيت كلمة المرور؟',
          'sign in': 'تسجيل الدخول',
          'signing in': 'تسجيل الدخول',
          'sign in with google': 'تسجيل الدخول بحساب جوجل',
          'password reset': 'تغيير كلمة المرور',
          'we will send a password reset link to the email you enter':
              'سنرسل رابط تغيير كلمة المرور الى البريد الالكتروني الذي تدخله',
          'send': 'ارسال',
          'sending': 'ارسال',
          'create profile': 'انشاء حساب',
          'full name': 'الاسم الكامل',
          'continue': 'الاستمرار',
          'take measurements': 'اخذ القياسات',
          'metric': 'متري',
          'imperial': 'انشي',
          'gender': 'الجنس',
          'age': 'العمر',
          'height (cm)': ' الطول (سنتيميتر)',
          'height (inch)': ' الطول (بوصة)',
          'weight (kg)': ' الوزن (كيلوجرام)',
          'weight (lb)': ' الوزن (رطل)',
          'activity level': 'مستوى النشاط',
          'protein percentage': 'نسبة البروتين',
          'carbs percentage': 'نسبة الكربوهيدرات',
          'fat percentage': 'نسبة الدهون',
          'm, cm, kg': 'م, سم, كج',
          'ft, inch, lb': 'قدم, بوصة, رطل',
          'registering': 'انشاء الحساب',
          'please enter macro values that add up to 100%.':
              'الرجال ادخال قيم للمغذيات مجموعها ١٠٠٪.',
          'male': 'ذكر',
          'female': 'انثى',
          'basal metabolic rate (bmr)': 'المعدل الايضي الاساسي',
          'basal metabolic rate': 'المعدل الايضي الاساسي',
          'sedentary: little or no exercise':
              'ساكن: القليل من او انعدام التمرين',
          'light: exercise 1-3 times a weak':
              'خفيف الحركة: التمرين ١-٣ مرات في الاسبوع',
          'moderate: exercise 4-5 times a weak':
              'معتدل الحركة: التمرين ٤-٥ مرات في الاسبوع',
          'very active: exercise 6-7 times a weak':
              'نشيط: التمرين ٦-٧ مرات في الاسبوع',
          'super active: daily exercise twice and a physical job':
              'نشيط جدا: التمرين الي ومي مرتين وعمل بدني',
          'enter a valid email.': 'ادخل بريدا الكترونيا صالحا للاستخدام.',
          'password must be more than 6 characters.':
              'ينبغي ان تتكون كلمة المرور من ٦ احرف فاكثر.',
          'enter a valid full name.': 'ادخل اسما كاملا صالحا للاستخدام.',
          'enter a valid gender.': 'ادخل جنسا صالحا للاستخدام.',
          'enter a valid age.': 'ادخل عمرا صالحا للاستخدام.',
          'enter a valid height.': 'ادخل طولا صالحا للاستخدام.',
          'enter a valid weight.': 'ادخل وزنا صالحا للاستخدام.',
          'enter a valid activity level.': 'ادخل مستوى نشاط صالح للاستخدام.',
          'enter a valid protein percentage.':
              'ادخل نسبة بروتين صالحة للاستخدام.',
          'enter a valid carbs percentage.':
              'ادخل نسبة كربوهيدرات صالحة للاستخدام.',
          'enter a valid fat percentage.': 'ادخل نسبة دهون صالحلا للاستخدام.',
          'email or password entered do not correspond to any account. please check your information.':
              'البريد الالكتروني او كلمة المرور المدخلان لا يتطابقان مع اي حساب. الرجاء التاكد من المعلومات.',
          'the email address you entered is already in use by a different account.':
              'البريد الالكتروني المدخل مستخدم في حساب اخر مسبقا.',
          'network error. please try again later.':
              'خطأ في الشبكة. الرجاء المحاولة في وقت لاحق.',
          'too many requests. please wait before trying again.':
              'الكثير من المحاولات. الرجاء الانتظار قبل المحاولة مرة ثانية.',
          'no account is associated with the entered email address.':
              'لا يوجد حساب يتطابق مع البريد الالكتروني المدخل.',
          'error occurred': 'حدث خطأ',
          'confirmation': 'تأكيد',
          'all the information you entered will be lost. are you sure you want to exit?':
              'كل المعلومات التي ادخلتها ستفقد. هل انت متأكد من الخروج؟',
          'all the information you edited will be lost. are you sure you want to exit?':
              'كل المعلومات التي عدلتها ستفقد. هل انت متأكد من الخروج؟',
          'all the information you edited will be lost. are you sure you want to cancel editing?':
              'كل المعلومات التي عدلتها ستفقد. هل انت متأكد من الغاء التعديل؟',
          'okay': 'حسنا',
          'cancel': 'الغاء',
          'calories': 'سعرة',
          'joules': 'جول',
          'kg': 'كج',
          'lb': 'رطل',
          'current weight': 'الوزن الحالي',
          'protein': 'بروتين',
          'carbs': 'كربوهيدرات',
          'fat': 'دهون',
          'gain weight': 'زيادة الوزن',
          'lose weight': 'فقدان الوزن',
          'maintenance': 'ثبات الوزن',
          'g': 'غ',
          'weight': 'الوزن',
          'error fetching user data.': 'حدث خطأ اثناء جلب معلومات المتسخدم.',
          'profile': 'الحساب',
          'save changes': 'حفظ التغييرات',
          'edit information': 'تعديل المعلومات',
          'measure': 'قياس',
          'all selections will be lost. are you sure you want to cancel editing?':
              'كل التحديدات سيتم فقدانها. هل انت متأكد من الغاء التعديل؟',
          'selected measurements will be deleted. are you sure you want to continue?':
              'القياسات المحددة سيتم حذفها. هل انت متأكد من الحذف؟',
          "there aren't any measurements.": 'لا توجد اي قياسات.',
          'take a measurement': 'اخذ القياسات',
          'calculating': 'يتم الحساب',
          'calculate': 'احسب',
          'measurement': 'قياس',
          'settings': 'الاعدادات',
          'theme': 'المظهر',
          'light': 'ساطع',
          'dark': 'داكن',
          'energy': 'وحدة الطاقة',
          'are you sure you want to sign out of your account?':
              'هل انت متاكد من تسجيل الخروج؟',
          'signing out': 'يتم تسجيل الخروج',
          'sign out': 'تسجيل الخروج',
          'home': 'الرئيسية',
        },
        'en': {
          'welcome,': 'Welcome,',
          'sign in to continue': 'Sign in to continue',
          'register': 'Register',
          'email': 'Email',
          'password': 'Password',
          'forgot password?': 'Forgot Password?',
          'sign in': 'Sign in',
          'signing in': 'Signing in',
          'sign in with google': 'Sign in With Google',
          'password reset': 'Password Reset',
          'we will send a password reset link to the email you enter':
              'We will send a password reset link to the email you enter',
          'send': 'Send',
          'sending': 'Sending',
          'create profile': 'Create Profile',
          'full name': 'Full Name',
          'continue': 'Continue',
          'take measurements': 'Take Measurements',
          'metric': 'Metric',
          'imperial': 'Imperial',
          'gender': 'Gender',
          'age': 'Age',
          'height (cm)': 'Height (Cm)',
          'height (inch)': 'Height (Inch)',
          'weight (kg)': 'Weight (Kg)',
          'weight (lb)': 'Weight (lb)',
          'activity level': 'Activity Level',
          'protein percentage': 'Protein Percentage',
          'carbs percentage': 'Carbs Percentage',
          'fat percentage': 'Fat Percentage',
          'm, cm, kg': 'm, cm, kg',
          'ft, inch, lb': 'ft, inch, lb',
          'registering': 'Registering',
          'please enter macro values that add up to 100%.':
              'Please enter macro values that add up to 100%.',
          'male': 'Male',
          'female': 'Female',
          'basal metabolic rate (bmr)': 'Basal Metabolic Rate (BMR)',
          'basal metabolic rate': 'Basal Metabolic Rate',
          'sedentary: little or no exercise':
              'Sedentary: Little or no Exercise',
          'light: exercise 1-3 times a weak':
              'Light: Exercise 1-3 Times a Weak',
          'moderate: exercise 4-5 times a weak':
              'Moderate: Exercise 4-5 Times a Weak',
          'very active: exercise 6-7 times a weak':
              'Very Active: Exercise 6-7 Times a Weak',
          'super active: daily exercise twice and a physical job':
              'Super Active: Daily Exercise Twice And a Physical Job',
          'enter a valid email.': 'Enter a valid email.',
          'password must be more than 6 characters.':
              'Password must be more than 6 characters.',
          'enter a valid full name.': 'Enter a valid full name.',
          'enter a valid gender.': 'Enter a valid gender.',
          'enter a valid age.': 'Enter a valid age.',
          'enter a valid height.': 'Enter a valid height.',
          'enter a valid weight.': 'Enter a valid weight.',
          'enter a valid activity level.': 'Enter a valid activity level.',
          'enter a valid protein percentage.':
              'Enter a valid protein percentage.',
          'enter a valid carbs percentage.': 'Enter a valid carbs percentage.',
          'enter a valid fat percentage.': 'Enter a valid fat percentage.',
          'email or password entered do not correspond to any account. please check your information.':
              'Email or password entered do not correspond to any account. Please check your information.',
          'the email address you entered is already in use by a different account.':
              'The email address you entered is already in use by a different account.',
          'network error. please try again later.':
              'Network error. Please try again later.',
          'too many requests. please wait before trying again.':
              'Too many requests. Please wait before trying again.',
          'no account is associated with the entered email address.':
              'No account is associated with the entered email address.',
          'error occurred': 'Error Occurred',
          'confirmation': 'Confirmation',
          'all the information you entered will be lost. are you sure you want to exit?':
              'All the information you entered will be lost. Are you sure you want to exit?',
          'all the information you edited will be lost. are you sure you want to exit?':
              'All the information you edited will be lost. Are you sure you want to exit?',
          'okay': 'Okay',
          'cancel': 'Cancel',
          'calories': 'Calories',
          'joules': 'Joules',
          'kg': 'Kg',
          'lb': 'lb',
          'current weight': 'Current Weight',
          'protein': 'Protein',
          'carbs': 'Carbs',
          'fat': 'Fat',
          'gain weight': 'Gain Weight',
          'lose weight': 'Lose Weight',
          'maintenance': 'Maintenance',
          'g': 'g',
          'weight': 'Weight',
          'error fetching user data.': 'Error fetching user data.',
          'profile': 'Profile',
          'save changes': 'Save Changes',
          'edit information': 'Edit information',
          'measure': 'Measure',
          'all selections will be lost. are you sure you want to cancel editing?':
              'All selections will be lost. Are you sure you want to cancel editing?',
          'selected measurements will be deleted. are you sure you want to continue?':
              'Selected measurements will be deleted. Are you sure you want to continue?',
          "there aren't any measurements.": "There aren't any measurements.",
          'take a measurement': 'Take a Measurement',
          'calculating': 'Calculating',
          'calculate': 'Calculate',
          'measurement': 'Measurement',
          'settings': 'Settings',
          'theme': 'Theme',
          'light': 'Light',
          'dark': 'Dark',
          'energy': 'Energy',
          'are you sure you want to sign out of your account?':
              'Are you sure you want to sign out of your account?',
          'signing out': 'Signing Out',
          'sign out': 'Sign Out',
          'home': 'Home',
        },
      };
}
