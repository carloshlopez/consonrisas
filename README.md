# Conectando Sonrisas

Una red social para crear y apoyar eventos sociales que generan sonrisas

Este proyecto utiliza Rails ~~3.0.1.~~ 3.2.14 y varios gems 

## Para empezar
<ol>
<li>Tener instalado ruby 1.9.2 y rails 3.2.14</li>

<li>Hacerle clone al proyecto de github<\li>

<li> Correr el comando bundle install<\li>
</ol>

## Lo que utilizamos

Para renderizar el html utilizamos haml, pero puedes usar erb si prefieres

Para css utilizamos sass, todo lo importamos a un solo .css y ese es el que se sube al hosting, entonces es importante hacer import en new.scss de los nuevos scss que se agreguen, y tener cuidado con el initializer sass.rb en el cual hay que dejar siempre esta linea Sass::Plugin.options[:never_update] = true, pero hay que comentarla cuando se trabaja local.

El proyecto está utilizando el hosting heroku, por lo tanto para utilizar background jobs, se utiliza DelayedJob (DJ) o SimpleWorker, el que prefieran. Pronto se agregará la utilización de hirefire para levantar y bajar los workers de heroku automáticamente.

Ventajas de DJ: Tienes acceso a todo el ambiente de la app, a todos los modelos, etc
con simpleworker, toca importar el ambiente al servidor de ellos, y desde allá no se tiene acceso a las bases de datos del proyecto, ya que está en hosting en heroku y no hay acceso desde a fuera para las dbs. Por ahora utilizamos SimpleWorker para envío de correos y DelayedJob para operaciones sobre los datos de la app.GEMS


##GEMS
Paperclip
Devise


