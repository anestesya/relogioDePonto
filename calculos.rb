class Calculos
 HPD = 8.8 
 HPS = 44 
 
 #calcula o perio que eu trabalhei nesta manhã.
 def periodoDaManha( arg = {} ) #estou usando hashes para emular polimorfismo 
             #http://pt.wikipedia.org/wiki/Ruby_%28linguagem_de_programa%C3%A7%C3%A3o%29
  if !arg.nil
    hora_de_entrada = arg[0];
    hora_de_saida_pro_almoco = arg[1]
  else
   getHoras
 end

  $chM = getHours(hora_de_entrada, hora_de_saida_pro_almoco)
end

def getHours(i, o)
   he = i.to_f #he = hora de entrada
   hs = o.to_f #hs = hora de saída
   ch = hs - he
end

def calcHours(manha, tarde)
   if (cg-HPD).to_i == 0
       puts "Você trabalhou o normalmente hoje, apenas volte para sua casa e descanse. :)"
   else if (cg-HPD) < 0.0
        puts "Cara, amanhã você vai ter que pular da cama para repor esse horário."
        puts "Vai ficar devendo #{format("%.2f", cg - HPD)} horas."
        $horas_repor = format("%.2f", cg - HPD)
   else if (cg-$hpd) > 0.0
        puts "Cara hoje você se esforçou e trabalhou #{format("%.2f", cg - HPD)} de tempo extra."
        puts "Se você tiver uma cerveja na sua casa, tome-á ;) "
        $horas_livres = format("%.2f", cg - HPD)
   end
end

#calcula as horas trabalhadas no período da tarde.
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
end #fim da classe