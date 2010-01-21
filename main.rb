#relogio de ponto usado para medir e guardar as horas trabalhadas.

$hpd= 8.8 #horas por dia #variaveis criadas com cifrão são variáveis globais.
$hps = 44 #horas por semana

#verifica se tem argumentos.
if !ARGV[0]
  puts "Usage:" 
  puts "      $ruby main.rb [hora entrada] [hora saida do almoco] [hora entra do almoco] [hora de ir embora]"
  puts "EX:" 
  puts "      $ruby main.rb 8.30 12.30 13.30 18.30"
end

puts "\nCálculo das horas de trabalho."
puts "by anestesya(aka. Tadeu Luis)"

#calcula o perio que eu trabalhei nesta manhã.
def periodoDaManha( arg = {} ) #estou usando hashes para emular polimorfismo 
			       #http://pt.wikipedia.org/wiki/Ruby_%28linguagem_de_programa%C3%A7%C3%A3o%29
  if ARGV[0]
    hora_de_entrada = ARGV[0]
    hora_de_saida_pro_almoco = ARGV[1]
  else
   puts ""
   puts "Digite as horas trabalhadas:"
   puts "ex: 8.30 para (8:30):"
   puts "Hora de Entrada: #{hora_de_entrada = gets.chomp}"
   puts "Hora de saída para almoço.#{hora_de_saida_pro_almoco = gets.chomp}"
 end

  $chM = getHours(hora_de_entrada, hora_de_saida_pro_almoco)
  return
end


def getHours(i, o)
   he = i.to_f #he = hora de entrada
   hs = o.to_f #hs = hora de saída
   ch = hs - he
   return ch
end

#calcula todos períodos trabalhados hoje.
def calcHours(manha, tarde)
   puts "" 
   puts "########################### Horas trabalhadas ############################"
   puts "O total de horas por dia é 8.8:"
   
   if (cg-$hpd).to_i == 0
	puts "Você trabalhou o normalmente hoje, apenas volte para sua casa e descanse. :)"
   else if (cg-$hpd) < 0.0
	puts "Cara, amanhã você vai ter que pular da cama para repor esse horário."
	puts "Vai ficar devendo #{format("%.2f", cg - $hpd)} horas."
        $horas_repor = format("%.2f", cg - $hpd)
   else if (cg-$hpd) > 0.0
        puts "Cara hoje você se esforçou e trabalhou #{format("%.2f", cg - $hpd)} de tempo extra."
        puts "Se você tiver uma cerveja na sua casa, tome-á ;) "
        $horas_livres = format("%.2f", cg - $hpd)
   end
end

def periodoDaTarde( args={} )
   if ARGV[0]
    hora_de_entrada_do_almoco = ARGV[2]
    hora_de_saida_da_empresa = ARGV[3]
  else
   puts ""
   puts "Hora do fim do almoço: #{hora_de_entrada_do_almoco = gets.chomp}"
   puts "Hora da saída pra casa: #{hora_de_saida_da_empresa = gets.chomp}"
  end
  
  $chT = getHours(hora_de_entrada_do_almoco, hora_de_saida_da_empresa)
   
   calcHours($chM, $chT)  
   return
end
  
  periodoDaManha
  periodoDaTarde
  
