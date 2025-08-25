class AddUserToProduct < ActiveRecord::Migration[8.0]
  def change
    # 1️⃣ Agregamos la columna user_id a products, inicialmente permitiendo NULL
    add_reference :products, :user, foreign_key: true

    # 2️⃣ Backfill: asignar todos los productos existentes a un usuario "SystemUser"
    reversible do |dir|
      dir.up do
        # Creamos un usuario system si no existe
        user = User.first || User.create!(
          name: "SystemUser",
          email: "system@ivi.com",
          password: "123456",
          password_confirmation: "123456"
        )

        # Asignamos todos los productos existentes a este usuario
        Product.update_all(user_id: user.id)
      end
    end

    # 3️⃣ Forzamos NOT NULL en user_id
    change_column_null :products, :user_id, false
  end
end
