# Challenge-Hunty
Challenge para la empresa Hunty

Entre los supuestos desarrollados se toman que:
1. A mayor puntaje mayor posibilidad tiene el candidato de ser nuevamente contactado o seleccionado
2. Las respuestas de los candidatos todas fueron cambiadas a "Active Response"

# Para el esquema relacional las tablas se basaron tomando en cuenta que: 

1. Es mejor tener una tabla con muchas filas, que una con muchas columnas,esto debido al manejo de la informacion
2. Se desarrollaron en total 3 tablas, conectadas la una entre otra ya sea por el id del cliente o el id de la pregunta
3. Se generan de forma tal que es posible agregar nuevas entradas sin necesidad de agregar o modificar las columnas existentes, teniendo un mayor manejo de datos

# En la carpeta Challenge_data se encuentra la infromacion subministrada para este challenge

# En la carpeta Clean_data se encuenran las 3 tablas base que desarrolle para las pruebas en SQL y el análisis de resultados

# En la carpeta code esta el codigo desarrollado tanto en SQL como en Python

Como informacion adicional, encontre que en la informacion subministrada en la raw conversation hay errores, debido a que para el candidato "dd05c95f3ce677fdaffb260f461216cae8d113c5f12f3e21e03b4e5281ff1504" no hay entradas en su conversación, sin embargo, este candidato aparece como si hubiese resuelto todas las preguntas y posee un score de 90, el cual es de los mayores scores de entre los candidatos
