$horas_por_dia = 8.8
$horas_na_semana = 44
$carga_horaria = 0
puts "escrever uma função que calcula as horas trabalhadas e compara com a hora exigida para a carga horaria."

def periodoDaManha
  puts "vamos ver quanto vc trabalhou no perído da manhã.\n Digite a hora de entrada:"
  hora_de_entrada = gets.chomp

  puts "digite a hora do que vc saiu para almoçar."
  hora_de_saida_pro_almoco = gets.chomp

   $carga_horaria = hora_de_saida_pro_almoco.to_f-hora_de_entrada.to_f
   puts "Horas trabalhadas nesta manhã"
   puts $carga_horaria
end


def periodoDaTarde
   puts "Digite a hora que vc chegou do seu almoço"
   hora_de_entrada_do_almoco = gets.chomp

   puts "Digite a hora que vc saiu da empresa após o almoço"
   hora_de_saida_da_empresa = gets.chomp

   $carga_horaria = $carga_horaria + (hora_de_saida_da_empresa.to_f-hora_de_entrada_do_almoco.to_f)

   puts "Horas totais trabalhadas hj"
   puts $carga_horaria
end

   periodoDaManha
   periodoDaTarde

   puts "Vc trabalhou"
   puts $carga_horaria
   puts "hoje, em comparação com o total de horas diarias exigida é: "
   puts $horas_por_dia.to_f-$carga_horaria.to_f

