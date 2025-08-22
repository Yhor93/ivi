# Subida de Imágenes en Rails 8 con Active Storage

Este documento describe el flujo completo para permitir que un modelo en Rails suba, muestre y reemplace imágenes usando **Active Storage**.

---

## 1. Instalar y configurar Active Storage

En la raíz del proyecto, ejecutar:

```bash
rails active_storage:install
rails db:migrate
```

Esto crea las tablas necesarias para manejar archivos en la base de datos.

---

## 2. Configurar el modelo

En el modelo `Product` (o el que corresponda), añadir:

```ruby
class Product < ApplicationRecord
  has_one_attached :photo
end
```

Esto crea la asociación para manejar un archivo adjunto llamado `photo`.

---

## 3. Permitir el parámetro en el controlador

En `products_controller.rb`, asegurarse de permitir el campo `photo`:

```ruby
def product_params
  params.require(:product).permit(:title, :price, :description, :photo)
end
```

---

## 4. Modificar el formulario

En `_form.html.erb`, añadir un campo para subir la imagen:

```erb
<div>
  <%= form.label :photo, "Imagen del producto" %><br>
  <%= form.file_field :photo %>
</div>
```

---

## 5. Mostrar la imagen en `index.html.erb` y `show.html.erb`

```erb
<% if product.photo.attached? %>
  <%= image_tag product.photo, style: "max-width: 200px; height: auto;" %>
<% end %>
```

Esto verifica si hay una imagen y la muestra.

---

## 6. Reemplazar la imagen al editar

Active Storage reemplaza automáticamente el archivo si el usuario sube uno nuevo en el formulario de edición.

---

## 7. Eliminar imágenes (opcional)

Para eliminar una imagen:

```ruby
product.photo.purge
```

Esto elimina la imagen asociada tanto de la base de datos como del almacenamiento local.

---

## Notas importantes

- Rails por defecto guarda las imágenes en `storage/` en modo desarrollo.
- En producción se debe configurar un servicio como Amazon S3, Google Cloud Storage, Azure, etc.
- El nombre del campo (`photo`) debe coincidir en **modelo**, **controlador** y **formulario**.
