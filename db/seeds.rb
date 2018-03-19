# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Admin.create(email: 'fmsandoval@uc.cl', password: 'iic3103t1fmsandoval')
Post.create(title: 'Titular 1.', lead: 'Bajada de la noticia 1.', body: 'Cuerpo de la noticia 1.')
Post.create(title: 'Titular 2.', lead: 'Bajada de la noticia 2.', body: 'Cuerpo de la noticia 2. Otra linea para que sea un poco mas largo.')
Post.create(title: 'Titular 3.', lead: 'Bajada de la noticia 3.', body: 'Cuerpo de la noticia 3.')
Comment.create(commenter: 'Comentador 1', body: 'Cuerpo del comentario 1.', post_id: 1)