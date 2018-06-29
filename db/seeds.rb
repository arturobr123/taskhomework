User.create!([
  {email: "arturo.bravo-ext@faurecia.com", encrypted_password: "$2a$11$zBs35/yE16UMP.LVg7GWn.PZ1L0sqxZrSyQCOX3W6nlncsgxj/awS", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 36, current_sign_in_at: "2018-06-28 23:41:08", last_sign_in_at: "2018-06-28 23:20:06", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "Arturo", firs_last_name: "Bravo", second_last_name: "Rovirosa", phone: nil, points: nil, status: nil, uid: nil, provider: nil, avatar_file_name: "IMG_5834.JPG", avatar_content_type: "image/jpeg", avatar_file_size: 1864777, avatar_updated_at: "2018-06-17 20:25:09", stripe_customer_token: "cus_D4hIgoy17kXdod", card1: nil, rank: 5.0}
])
Admin.create!([
  {email: "admin1@faurecia.com", encrypted_password: "$2a$11$KRq8qUrzGUMgVBMIMe77fe7l20cVFq4eeiWrwv7rPmXUau8Ialkxq", reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 27, current_sign_in_at: "2018-06-28 23:42:12", last_sign_in_at: "2018-06-28 23:41:36", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1", name: "Admin", uid: nil, provider: nil, avatar_file_name: nil, avatar_content_type: nil, avatar_file_size: nil, avatar_updated_at: nil, stripe_customer_token: "cus_D4iqcpbPybwyEj", rank: 4.75}
])
Archive.create!([
  {archivo_file_name: "cover_letter_twitter.docx", archivo_content_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", archivo_file_size: 106974, archivo_updated_at: "2018-06-15 03:01:11", homework_id: 19},
  {archivo_file_name: "cover_letter_twitter.pdf", archivo_content_type: "application/pdf", archivo_file_size: 15637, archivo_updated_at: "2018-06-15 03:01:11", homework_id: 19},
  {archivo_file_name: "carta_Seguro.docx", archivo_content_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", archivo_file_size: 78660, archivo_updated_at: "2018-06-20 02:34:41", homework_id: 24},
  {archivo_file_name: "cover_letter_twitter.pdf", archivo_content_type: "application/pdf", archivo_file_size: 15637, archivo_updated_at: "2018-06-20 02:34:41", homework_id: 24},
  {archivo_file_name: "ResumeArturoBravo.docx", archivo_content_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", archivo_file_size: 19922, archivo_updated_at: "2018-06-20 02:35:38", homework_id: 25},
  {archivo_file_name: "ResumeArturoBravo.pdf", archivo_content_type: "application/pdf", archivo_file_size: 45672, archivo_updated_at: "2018-06-20 02:35:38", homework_id: 25},
  {archivo_file_name: "carta_Seguro.docx", archivo_content_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", archivo_file_size: 78660, archivo_updated_at: "2018-06-20 12:33:29", homework_id: 26},
  {archivo_file_name: "ResumeArturoBravo.pdf", archivo_content_type: "application/pdf", archivo_file_size: 45672, archivo_updated_at: "2018-06-20 12:33:29", homework_id: 26},
  {archivo_file_name: "carta_Seguro.docx", archivo_content_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", archivo_file_size: 78660, archivo_updated_at: "2018-06-20 12:34:22", homework_id: 27}
])
ArchiveClassroom.create!([
  {archivo_file_name: "cover_letter_twitter.docx", archivo_content_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", archivo_file_size: 106974, archivo_updated_at: "2018-06-20 01:45:48", classroom_id: 4},
  {archivo_file_name: "cover_letter_twitter.pdf", archivo_content_type: "application/pdf", archivo_file_size: 15637, archivo_updated_at: "2018-06-20 01:45:48", classroom_id: 4},
  {archivo_file_name: "cover_letter_twitter.pdf", archivo_content_type: "application/pdf", archivo_file_size: 15637, archivo_updated_at: "2018-06-24 01:00:32", classroom_id: 5},
  {archivo_file_name: "carta_Seguro.docx", archivo_content_type: "application/vnd.openxmlformats-officedocument.wordprocessingml.document", archivo_file_size: 78660, archivo_updated_at: "2018-06-24 13:19:54", classroom_id: 5},
  {archivo_file_name: "cover_letter_twitter.pdf", archivo_content_type: "application/pdf", archivo_file_size: 15637, archivo_updated_at: "2018-06-24 13:21:10", classroom_id: 5},
  {archivo_file_name: "Libro1.xlsx", archivo_content_type: "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet", archivo_file_size: 21680, archivo_updated_at: "2018-06-28 23:45:51", classroom_id: 6}
])
Classroom.create!([
  {homework_id: 19, status: nil, user_id: 1, admin_id: 1, scoreTrabajador: 4, proposal_id: 6},
  {homework_id: 27, status: nil, user_id: 1, admin_id: 1, scoreTrabajador: 5, proposal_id: 15},
  {homework_id: 25, status: nil, user_id: 1, admin_id: 1, scoreTrabajador: nil, proposal_id: 12}
])
Homework.create!([
  {deadline: "2018-06-18 00:00:00", description: "La tarea es un término empleado para referirse a la práctica de una obligación o a la realización de una actividad, bien sea en el ámbito educativo, en el hogar y también en el ámbito laboral. De acuerdo al interés o entusiasmo para ejecutar la actividad otorgada a la persona, las tareas pueden clasificarse en obligatorias o por placer: las tareas obli", name: "Ensayo de las matemáticas", numberpages: 4, user_id: 1, admin_id: nil, level: 2, tipo: 1, status: 3, minPrice: 100, maxPrice: 500},
  {deadline: "2018-07-18 00:00:00", description: "In this article we will walk through a simple app to demonstrate how to send emails through a Rails application with ActionMailer, ActionMailer Preview, and through a third party email service provider such as Gmail or Mailgun. We will also demostrate how to use Active Job to send the email with a background processor.", name: "Ensayo de la historia de México", numberpages: 20, user_id: 1, admin_id: nil, level: 2, tipo: 1, status: 1, minPrice: 100, maxPrice: 500},
  {deadline: "2018-06-30 00:00:00", description: "in this homework takes user parameters and sends email using method mail to email address of user. In case you want to know about more features like attachment and multiple receivers, you can check out rails guide in the reference section. Now let’s write the mail we want to send to our users, and this can be done in app/views/example_mailer. Create a file sample_email.html.erb which is an email formatted in HTML.", name: "Ecuaciones diferenciales", numberpages: 10, user_id: 1, admin_id: nil, level: 2, tipo: 1, status: 2, minPrice: 100, maxPrice: 500},
  {deadline: "2018-07-20 00:00:00", description: "Elasticsearch is sort of like a very large, complex NoSQL document based database. The rough idea is that every record we want to search becomes a document in an elasticsearch index. Elasticsearch uses mappings to define how a document and the fields it contains are stored and how they will later be searched. The mapping is somewhat like an elasticsearch ‘schema’.", name: "Derivadas multiples", numberpages: 2, user_id: 1, admin_id: nil, level: 2, tipo: 1, status: 1, minPrice: 100, maxPrice: 500},
  {deadline: "2018-07-25 00:00:00", description: "Thankfully, by using the searchkick gem we get to bypass a lot of the set up and implementation details. By just setting searchkick on our models, the gem will create corresponding elasticsearch indexes. It decides the structure of our fields and mappings based on our model attributes. Searchkick also handles automatically updating our index when we add new records or change existing records. Without searchkick we would ‘manually’ have to issue requests to elasticsearch via the http api.", name: "Examen de matemáticas", numberpages: 2, user_id: 1, admin_id: nil, level: 2, tipo: 1, status: 3, minPrice: 100, maxPrice: 500}
])
Notification.create!([
  {user_id: 1, item_type: "Proposal", item_id: 14, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 15, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 16, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 17, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 18, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 19, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 20, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 21, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 22, viewed: true},
  {user_id: 1, item_type: "Proposal", item_id: 23, viewed: true},
  {user_id: 1, item_type: "ArchiveClassroom", item_id: 10, viewed: true},
  {user_id: 1, item_type: "Homework", item_id: 27, viewed: true},
  {user_id: 1, item_type: "Homework", item_id: 19, viewed: true},
  {user_id: 1, item_type: "Homework", item_id: 27, viewed: true},
  {user_id: 1, item_type: "Homework", item_id: 19, viewed: true},
  {user_id: 1, item_type: "Homework", item_id: 27, viewed: true},
  {user_id: 1, item_type: "Homework", item_id: 27, viewed: true}
])
NotificationWorker.create!([
  {admin_id: 1, item_type: "Classroom", item_id: 5, viewed: false},
  {admin_id: 1, item_type: "Classroom", item_id: 6, viewed: false}
])
Proposal.create!([
  {admin_id: 1, homework_id: 19, cost: 400.0, notes: "El nivel microestructural o local está asociado con el concepto de cohesión. Se refiere a uno de los fenómenos propios de la coherencia, el de las relaciones particulares y locales que se dan entre elementos lingüísticos, tanto los que remiten unos a otros como los que tienen la función de conectar y organizar. También es un conjunto de oraciones agrupadas en párrafos que habla de un tema determinado.", deadline: "2018-06-30 00:00:00", status: 3},
  {admin_id: 1, homework_id: 19, cost: 350.0, notes: "Las ideas esenciales que comunica un texto están contenidas en lo que se suele denominar «macroproposiciones», unidades estructurales de nivel superior o global, que otorgan coherencia al texto constituyendo su hilo central, el esqueleto estructural que cohesiona elementos lingüísticos formales de alto nivel.", deadline: "2018-06-29 00:00:00", status: 1},
  {admin_id: 1, homework_id: 19, cost: 300.0, notes: "Stripe te da la opción de crear el formulario de pago completo por tu cuenta, pero con Checkout te ofrecemos aún más ventajas: recopilamos información y realizamos tests constantemente con el objetivo de aumentar tus ingresos.", deadline: "2018-06-30 00:00:00", status: 1},
  {admin_id: 1, homework_id: 25, cost: 400.0, notes: "When the mail method will be triggered, it will send a multipart email with an attachment, properly nested with the top level being multipart/mixed and the first part being a multipart/alternative containing the plain text and HTML email messages.", deadline: "2018-06-23 00:00:00", status: 2},
  {admin_id: 1, homework_id: 24, cost: 500.0, notes: "It seems to me that when I click the submit button the hidden value isn't being sent at all. Is the form not aware of the hidden field because it's not present at the start? How do I fix this.\r\n\r\nEverything worked fine with a simple radio button select.", deadline: "2018-07-18 00:00:00", status: 1},
  {admin_id: 1, homework_id: 24, cost: 1000.0, notes: "How much do Wizeline employees make? Glassdoor has salaries, wages, tips, bonuses, and hourly pay based upon employee reports and estimates.", deadline: "2018-06-30 00:00:00", status: 1},
  {admin_id: 1, homework_id: 27, cost: 400.0, notes: "También es una composición de caracteres imprimibles (con grafema) generados por un algoritmo de cifrado que, aunque no tienen sentido para cualquier persona, sí puede ser descifrado por su destinatario original. En otras palabras, un texto es un entramado de signos con una intención comunicativa que adquiere sentido en determinado contexto.", deadline: "2018-06-30 00:00:00", status: 3},
  {admin_id: 1, homework_id: 27, cost: 500.0, notes: "El nivel microestructural o local está asociado con el concepto de cohesión. Se refiere a uno de los fenómenos propios de la coherencia, el de las relaciones particulares y locales que se dan entre elementos lingüísticos, tanto los que remiten unos a otros como los que tienen la función de conectar y organizar. También es un conjunto de oraciones agrupadas en párrafos que habla de un tema determinado.", deadline: "2018-06-30 00:00:00", status: 1},
  {admin_id: 1, homework_id: 25, cost: 250.0, notes: "hola mundo", deadline: "2018-06-30 00:00:00", status: 1},
  {admin_id: 1, homework_id: 25, cost: 200.0, notes: "nueva notificacion", deadline: "2018-06-27 00:00:00", status: 1},
  {admin_id: 1, homework_id: 25, cost: 100.0, notes: "ahora siiiiii", deadline: "2018-06-28 00:00:00", status: 1},
  {admin_id: 1, homework_id: 25, cost: 100.0, notes: "ahora si", deadline: "2018-06-29 00:00:00", status: 1},
  {admin_id: 1, homework_id: 25, cost: 300.0, notes: "!!!", deadline: "2018-06-20 00:00:00", status: 1},
  {admin_id: 1, homework_id: 25, cost: 200.0, notes: "dfsadf", deadline: "2018-06-23 00:00:00", status: 1},
  {admin_id: 1, homework_id: 27, cost: 300.0, notes: "hola mundo", deadline: "2018-06-28 00:00:00", status: 1}
])
TC::Level.create!([
  {level: "Preparatoria"},
  {level: "Universidad"},
  {level: "Posgrado"}
])
TC::Score.create!([
  {score: "Mal"},
  {score: "Regular"},
  {score: "Bien"},
  {score: "Muy bien"},
  {score: "Excelente"}
])
TC::Status.create!([
  {status: "Disponible"},
  {status: "En proceso"},
  {status: "Finalizada"}
])
TC::Type.create!([
  {tipo: "Matemáticas"},
  {tipo: "Español"},
  {tipo: "Ingles"}
])
