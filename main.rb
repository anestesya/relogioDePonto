#relogio de ponto usado para medir e guardar as horas trabalhadas.

require 'optparse'

$hpd= 8.8 #horas por dia #variaveis criadas com cifrão são variáveis globais.
$hps = 44 #horas por semana

#verifica se tem argumentos.
if !ARGV[0]
  puts "Você pode tentar usar o programa da seguinte forma:"
  puts "Use: ruby main.rb hora_entrada hora_saida_almoco hora_entra_almoco hora_sai_empresa"
  puts "EX: ruby main.rb 8.30 12.30 13.30 18.30"
end

puts "Cálculo das horas de trabalho."
puts "by anestesya(aka. Tadeu Luis)"

#calcula o perio que eu trabalhei nesta manhã.
def periodoDaManha( arg = {} ) #estou usando hashes para emular polimorfismo http://pt.wikipedia.org/wiki/Ruby_%28linguagem_de_programa%C3%A7%C3%A3o%29
  if ARGV[0]
    hora_de_entrada = ARGV[0]
    hora_de_saida_pro_almoco = ARGV[1]
  elsif
   puts "Digite as informações abaixo:"
   puts "Hora de entrada: ex: 8.30 para (8:30), 14.20 para (14:20)"
   hora_de_entrada = gets.chomp
   puts "Hora de saída para almoço."
   hora_de_saida_pro_almoco = gets.chomp
 end

  $chM = getHours(hora_de_entrada, hora_de_saida_pro_almoco)
  return
end


def getHours(i, o)
   he = i.to_f #he = hora de entrada
   hs = o.to_f #hs = hora de saída
   puts ch = hs - he
   return ch
end

def calcHours(manha, tarde) 
   puts "Horas trabalhadas"
   puts cg = manha +  tarde
  
   puts "O total de horas por dia é 8.8:"
   puts "sua carga horaria hoje foi:"
   puts format("%.2f", cg - $hpd)
end

def periodoDaTarde( args={} )
   if ARGV[0]
    hora_de_entrada_do_almoco = ARGV[2]
    hora_de_saida_da_empresa = ARGV[3]
  elsif
   puts "Digite a hora que vc chegou do seu almoço"
   hora_de_entrada_do_almoco = gets.chomp
   puts "Digite a hora que vc saiu da empresa após o almoço"
   hora_de_saida_da_empresa = gets.chomp
  end
  
  $chT = getHours(hora_de_entrada_do_almoco, hora_de_saida_da_empresa)
   
   calcHours($chM, $chT)  
   return
end
  
  periodoDaManha
  periodoDaTarde
  