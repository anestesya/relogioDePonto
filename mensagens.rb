class Mensagens
   #verifica se tem argumentos.
  if !ARGV[0]
    puts "Usage:" 
    puts "      $ruby main.rb [hora entrada] [hora saida do almoco] [hora entra do almoco] [hora de ir embora]"
    puts "EX:" 
    puts "      $ruby main.rb 8.30 12.30 13.30 18.30"
  end

  puts "\nCálculo das horas de trabalho."
  puts "by anestesya(aka. Tadeu Luis)"


end #fim da classe


 #manha
 def getHoras
   puts ""
   puts "Digite as horas trabalhadas:"
   puts "ex: 8.30 para (8:30):"
   puts "Hora de Entrada: #{hora_de_entrada = gets.chomp}"
   puts "Hora de saída para almoço.#{hora_de_saida_pro_almoco = gets.chomp}"
 end
 
 def showCalcs
   puts "" 
   puts "########################### Horas trabalhadas ############################"
   puts "O total de horas por dia é 8.8:"
 end