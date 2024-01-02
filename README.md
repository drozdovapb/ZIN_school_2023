# ZIN_school_2023
## (Всероссийская школа молодых ученых «Высокопроизводительное секвенирование, получение и анализ данных в филогенетике»)

This folder contains data and code for the phylogenomics workshops to be held at this school:
https://www.zin.ru/conferences/brc_school_2023/

- `presentation`: презентации
  - `Stepik_pres`: эти материалы подробно рассмотрены в курсе на Stepik (https://stepik.org/course/2054/syllabus).
- `scripts`: примеры кода для каждого упражнения в презентации.



Jupyter Notebook:
- Для линукса войти в jupyter notebook локально (если localhost отличается от 10000, например 10001, то нужно соответственно заменить везде 10000 на 10001
- В терминале на сервере:
`jupyter notebook --no-browser --port 10000`
- Скопировать ссылку вида: (Она будет под строчкой "Or copy and paste one of these URLs:")http://localhost:10000/tree?token=<TOKEN>
- В терминале на локальном компьютере:
`ssh -NL localhost:10000:localhost:10000 <username>@server -p xxx`
- Ввести пароль
- Вставить в браузер ссылку вида `http://localhost:10000/tree?token=<TOKEN>`