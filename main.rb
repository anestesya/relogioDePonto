#relogio de ponto usado para medir e guardar as horas trabalhadas.
$hpd= 8.8 #horas por dia #variaveis criadas com cifrão são variáveis globais.
$hps = 44 #horas por semana

puts "Cálculo das horas de trabalho."
puts "by anestesya(aka. Tadeu Luis)"

#calcula o perio que eu trabalhei nesta manhã.
def periodoDaManha
  puts "Digite as informações abaixo:"
  puts "Hora de entrada: ex: 8.30 para (8:30), 14.20 para (14:20)"
  hora_de_entrada = gets.chomp
  puts "Hora de saída para almoço."
  hora_de_saida_pro_almoco = gets.chomp

  $chM = getHours(hora_de_entrada, hora_de_saida_pro_almoco)
  return
end

def getHours(i, o)
   he = i.to_f #he = hora de entrada
   hs = o.to_f #hs = hora de saída
   puts ch = ho - h1
   return ch
end

def calcHours(manha, tarde) 
   puts "Horas trabalhadas"
   puts cg = manha +  tarde
  
   puts "O total de horas por dia é 8.8:"
   puts "sua carga horaria hoje foi:"
   puts cg - $hpd
end

def periodoDaTarde
   puts "Digite a hora que vc chegou do seu almoço"
   hora_de_entrada_do_almoco = gets.chomp
   puts "Digite a hora que vc saiu da empresa após o almoço"
   hora_de_saida_da_empresa = gets.chomp

   $chT = getHours(hora_de_entrada_do_almoco, hora_de_saida_da_empresa)
   
   calcHours($chM, $chT)  
   return
end

   periodoDaManha
   periodoDaTarde

