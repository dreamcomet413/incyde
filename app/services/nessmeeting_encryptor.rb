class NessmeetingEncryptor

  attr_accessor :patron_busqueda, :patron_encripta

  def initialize()
    # @patron_busqueda = "0123456789abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ@."
    # @patron_encripta = "JIoyLj1ilvgSdñ@UE3CAW4G2kbt78rcVKf0azQpwÑsDB6FXuZHTP9qNO5nmM.YeRhx"

    @patron_busqueda = "0123456789abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ_+-@."
    @patron_encripta = "JIoyLj1ilvgSd+ñ@UE3CAW4G2k-bt78rcVKf0azQpwÑsDB6FXuZHTP9qNO5_nmM.YeRhx"
  end

  def get_token(email)
    first_random_string_limit = 6
    first_random_string = rand(36**first_random_string_limit).to_s(36)
    "#{first_random_string}#{encriptar_cadena(email)}"
  end

  def encriptar_cadena(cadena)
    begin
      resultado = ""
      idx = 0
      while idx <= cadena.size - 1
        resultado += self.encriptar_caracter(cadena[idx, 1], cadena.size, idx)
        idx = idx + 1
      end
      return resultado
    rescue Exception => e
      Rails.logger.info "-------> ERROR EN NessmeetingEncryptor con la cadena '#{cadena}', excepcion => '#{e}'"
      return "-------------------"
    end
  end

  def encriptar_caracter(caracter, variable, a_indice)
    caracterEncriptado = ""
    if patron_busqueda.index(caracter) != -1 then
      indice = (patron_busqueda.index(caracter) + variable + a_indice) % patron_busqueda.size
      return patron_encripta[indice, 1]
    end
    return caracter
  end

  # En principio en nuestro lado no son necesarias estas funciones
  # def DesEncriptarCadena(cadena)
  #   resultado = ""
  #   idx = 0
  #   while idx <= cadena.size - 1
  #     resultado += self.DesEncriptarCaracter(cadena[idx, 1], cadena.size, idx)
  #     idx = idx + 1
  #   end
  #   return resultado
  # end
  #
  # def DesEncriptarCaracter(caracter, variable, a_indice)
  #   if patron_encripta.index(caracter) != -1 then
  #     if (patron_encripta.index(caracter) - variable - a_indice) > 0 then
  #       indice = (patron_encripta.index(caracter) - variable - a_indice) % patron_encripta.size
  #     else
  #       indice = (patron_busqueda.size) + ((patron_encripta.index(caracter) - variable - a_indice) % patron_encripta.size)
  #     end
  #     indice = indice % patron_encripta.size
  #     return patron_busqueda[indice, 1]
  #   else
  #     return caracter
  #   end
  # end


  def self.test(limit)
    User.limit(limit).each do |user|
      begin
        code = NessmeetingEncryptor.new.get_token user.email
        @result = Net::HTTP.get(URI.parse("http://www.nessmeeting.com/testParametros.aspx?param=#{URI.escape(code)}"))
      rescue
          @msg = "Excepcion en ===> "
      ensure
        @msg = @result.match("<p>#{user.email}</p>") ? "--->OK" : "----->ERROR"
        p "#{@msg} => #{user.email} vs #{@result.match("<p>(.*)</p>")[1]}"
      end
    end.count
  end

end
