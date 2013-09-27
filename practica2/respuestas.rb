# TTPS Opción Ruby

# Práctica 2: Ruby
# Repasando la sintaxis

# Nota: No usar while, for ni repeat.

# 1 ­ Si listamos todos los números naturales menores que 10 que son múltiplos de 3 o 5 obtenemos 3, 5, 6 y 9. 
# La suma de todos estos números es 23. Encontrá la suma de todos los múltiplos de 3 o 5 menores que 1000.
module Ejercicio1

  def multiple_of_3_or_5(num)
    num % 3 == 0 || num % 5 == 0
  end

  # Opción 1:
  sum = 0
  (1..1000).each do |n|
    sum += n if multiple_of_3_or_5(n)
  end

  # Opción 2:
  (1..1000).select {|n| multiple_of_3_or_5 n }.inject :+

  # Haskell
  # mult3or5 Int -> Bool
  # mult3or5 x = divides 3 x || divides 5 x

  # ejercicio = sum (filter mult3or5  1..1000)

end

# 2 ­ Cada nuevo término en la secuencia de Fibonacci es generado sumando los 2 términos anteriores. 
# Empezando con 1 y 2; los primeros 10 términos son: 1, 2, 3, 5, 8, 13, 21, 34, 55, 89. 
# Considerando los términos en la secuencia de Fibonacci cuyos valores no exceden los 4 millones, 
# encontrá la suma de los términos pares.

module Ejercicio2
  
  # Opción 1: (incompleta)
  def fib(num)
    x, y = 1, 1
    sum = 0
    (1..num).each do |n|
      x, y = y, x + y
      sum += y if n % 2 == 0
    end
  end

  # Opción 2: (Usando Enumerator)

  fibonacci = Enumerator.new do |caller|
    i1, i2 = 0, 1    
    loop do
      i1, i2 = i2, i1+i2
      caller.yield i2     
    end
  end

  current = fibonacci.next
  while current < 4000000
    puts current
    current = fibonacci.next
  end

end

# 3 ­ Un número palíndromo se lee igual al derecho y al revés. 
# El número palíndromo más grande obtenido de la multiplicación de dos números de 2 dígitos es 9009 (91 x 99 = 9009).
# Encontrá el palíndromo más grande obtenido a través de la multiplicación de dos números de 3 dígitos.

module Ejercicio3

  def palindromo?(num)
    str = num.to_s
    str.eql?(str.reverse)
  end

  max = 0

  (100..999).each do |n|
    (n..999).each do |m|
      if palindromo?(act = n*m)
        max = act if (act > max)
      end
    end
  end

  puts max # 906609

end

# 4 ­ 2520 es el número más chico que puede ser dividido por cada uno de los números del 1 al 10 sin obtener resto.
# ¿Cual es el número más chico que puede ser dividido por cada uno de los números del 1 al 20?

module Ejercicio4

  # Se está pidiendo el Mínimo Común Múltiplo de los números del 1 al 20. 
  # Resolveré utilizando el método +lcm+ provisto por Ruby.

  (1..10).inject :lcm #=>       2520
  (1..20).inject :lcm #=>  232792560

end

# 5 ­ La suma de los cuadrados de los primeros 10 números naturales es 385 (1^2 + 2^2 + … + 10^2 = 385).
# El cuadrado de la suma de los primeros 10 números naturales es 3025 ((1 + 2 + … + 10)^2 = 55^2 = 3025).
# Por lo tanto, la diferencia entre el cuadrado de la suma y la suma de los cuadrados de los primeros 10 números naturales es 2640 (3025 ­ 385 = 2640).
# Encontrá la diferencia entre el cuadrado de la suma y la suma de los cuadrados de los primeros 100 números naturales.

module Ejercicio5

  RANGO = 1..100

  suma = RANGO.map {|n| n**2 }.inject :+
  puts RANGO.inject(:+) **2 - suma

end

# 6 ­ La lista de los primeros 6 números primos es 2, 3, 5, 7, 11 y 13.
# Se puede observar que el 6to número primo es 13. ¿Cual es el número primo nro 10001?

module Primes # Ejercicio6

  def prime?(num)
    (2..(num-1)).each do |act|
      return false if num % act == 0
    end
    true
  end

  def primes
    Enumerator.new do |caller|
      i = 1
      loop do
        i+=1 
        i+=1 until prime?(i)
        caller.yield i     
      end
    end
  end

  p = primes
  p.first(10001).last #=> 104743 (Luego de 20 segundos de espera aprox.)

end

# 7 ­ La suma de los primos menores que 10 es 17 (2 + 3 + 5 + 7 = 17). 
# Encontrá la suma de todos los primos menores que 2 millones.

module Ejercicio7
  include Primes

  sum = 0
  p = primes

  while actual = p.next < 2000000
    sum += actual
  end

  sum

end

# 8 ­ Dado un arreglo de strings cualquiera, es necesario escribir un método que devuelva un arreglo con la longitud de dichos strings.
# Ejemplo: dado [‘Ruby’, ‘is’, ‘awesome’] debe retornar [4,2, 7]

module Ejercicio8

  def sizes(xs)
    xs.map {|x| x.size }
  end

  array = %w(Siempre lleva mas tiempo que el esperado, incluso si tienes en cuenta La Ley de Hofstadter)

  sizes(array)

end

# 9 ­ Dado un color expresado como una combinación RGB calcular su representación entera. 
# Consideramos que un color rgb se expresa como un hash con las claves [:red, :green, :blue], 
# y para cada una toma valores en el rango (0..255). Por ejemplo:
# { red: 0, green: 0, blue: 255 },
# { red: 128, green: 128, blue: 255 },
# La representación entera se calcula como: red + green*256 + blue*256²

# 9.b ­ Realizar el mismo cálculo obteniendo los coeficientes para cada componente del color de
# otro hash coefficients = { red: 256⁰, green: 256¹, blue: 256² }

module Ejercicio9

  # 9a
  def color_to_integer(color)
    color[:red] + color[:green]*256 + color[:blue]*(256**2)
  end

  
  #9b
  COEF = { red: 256**0, green: 256**1, blue: 256**2 }

  def color_to_integer_with_hash(color)
    color.merge(COEF){|key, v1, v2| v1*v2}.values.inject :+
  end

  color_to_integer { red: 128, green: 128, blue: 255 }            #=> 16744576
  color_to_integer_with_hash { red: 128, green: 128, blue: 255 }  #=> 16744576


end

# Clases y objetos
# 10 ­ Se quiere administrar una agenda electrónica. De cada contacto necesita guardarse:
#  Nombre
#  Fecha de nacimiento
#  Email
#  Teléfono
#  Dirección
# Se quiere hacer una aplicación de línea de comandos que permita:
#  Ver todos los contactos
#  Agregar un contacto
#  Editar un contacto
#  Buscar un contacto
# Los datos deben ser guardados en un archivo CSV.

module Ejercicio10

  class Contact

    attr_accessor :name, :birthdate, :email, :phone, :address

    def initialize(name, birthdate, email, phone, address)
      @name       = name
      @birthdate  = birthdate
      @email      = email
      @phone      = phone
      @address    = address
    end

  end

  require 'csv'

  class CSVReader

    def initialize
        @contacts = []
    end

    def read_in_csv_data(csv_file_name)
      CSV.foreach(csv_file_name, headers: true) do |row|
        @contacts << Contact.new(row["Name"], row["Birthdate"], row["Email"], row["Phone"], row["Addres"])
      end
    end

  end


end
