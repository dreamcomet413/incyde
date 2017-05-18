namespace :incyde do
  namespace :users do

    desc 'Copiar nombre de Viveros y viveristas de la tabla del perfil a la tabla usuarios'
    task copy_name: :environment do

      User.all.each do |user|
        if user.is_a?(Admin)
          user.update(name: "Admin #{user.id}")
        elsif user.is_a?(BusinessIncubator)
          user.update(name: user.profile.name)
        elsif user.is_a?(Company)
          user.update(name: user.profile.name)
        end
      end

    end

  end
end
