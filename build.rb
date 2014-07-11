#!/usr/bin/env ruby 
#encoding UTF-8

require 'erb'
require 'csv'
require 'fileutils'
require "#{Dir.pwd}/aniversariantes.rb"
require "#{Dir.pwd}/ferias.rb"
require 'premailer'
require 'rubygems'

contents = File.read('clean.erb')

def br(text)
  text = text.gsub(/\r/,"")
  text = text.gsub(/\n/,"<BR>")
end

def filled?(v)
  return false if ! defined? v
  return false if v.nil?
  return false if v.empty? 
  true
end

#Em 11 de Julho foi lançado o 047
boletimNumero = "048"

editorial = Array.new
editorialTexto = br("Vocês devem ter visto no Primeira Leitura, algo que está mexendo com toda a empresa, e agora tem o patrocínio da alta Direção. Um grupo designado pela Diretoria, com representantes de todas as áreas, está reunido há quase duas semanas discutindo, traçando estratégias e encaminhando ações para que a empresa passe a adotar a metodologia ágil. O caminho é longo, a mudança é gradativa, nossa pluralidade exigirá equilíbrio e adaptações, mas todo o investimento será recompensado, pois esse movimento não significa apenas um novo processo de trabalho, significa, entre outras coisas, algo muito maior - transformação de cultura!

Passaremos por um processo de mudança em que, naturalmente, algumas pessoas se adaptarão mais facilmente do que outras, alguns demonstrarão maior disposição, outros mais preocupação, mas estaremos juntos, como um único time, se ajudando frente aos novos desafios!

Devemos ter mais informações em breve.")
editorial.push({:t=>"", :c=>editorialTexto})

servicos = Array.new
homologacoes=br("SIGEPE-GED-AFD - Validação
Data: 07/07/2014
Objetivo: Validar a iteração 4 do SIGEPE-GED-AFD
Responsável: Vanderlei Souza

SIGEPE-PA - Validação
Data: 14/07/2014
Objetivo: Validar a iteração 7 do SIGEPE - Pensão Alimentícia
Responsável: Cezar Ronaldo
")
servicos.push({:t=>"HOMOLOGAÇÕES:", :c=>homologacoes})
eventos = Array.new
reunioesTxt=br("SIGEPE-Consignações - Inception do módulo Denúncias
Data: 20 a 22/07/2014
Objetivo: Realizar o evento de inception para levantar e priorizar o backlog do módulo Denúncias do SIGEPE-Consignações
Responsável: Sandro Almeida

22 a 24/7 - Reunião de retomada do sistema de Renda Variável com a RFB
Local: Sala Corporativa 09")
eventos.push({:t=>"REUNIÕES:", :c=>reunioesTxt})

viagensTxt=br("- Lucas Carvalho Rego

Objetivo: Participar da reunião de integração do módulo de julgamento entre os sistemas SIEF-Processos e e-Processo.
Período: 15/07/2014 a 18/07/2014.
Local: São Paulo (Serpro/Socorro)")

servicos.push({:t=>"VIAGENS:", :c=>viagensTxt})

pessoas = Array.new


cegonhaTxt =br("<div align='center'><img src='http://voce.serpro/articles/0106/3070/turma_da_cegonha.jpeg' height='197' width='197'></div>
Lucas Salles é o primeiro confirmado como Papai 2015, com previsão para Fevereiro. Como ainda está cedo, não sabemos o sexo.
Rogério Reis está esperando uma menina com o nome de Ananda.#")
babyboomTxt =br('<div align="center"><img id="irc_mi" src="http://www.petitepalate.com/pp/images/babies.jpg" width="668" height="180" "></div>
BABY BOOM - Nesta edição de Julho/2014 os contemplados são: 
Liz (papai Slomka)
Júlia (papai Lucas)
Maria Sofia (papai Carlos eugênio)

Vamos fazer o chá de fraldas no dia 30/07 (quarta-feira) à partir das 16h no Pilotis.

Convidamos você para participar conosco, trazendo o tradicional pacote de fraldas (Turma da Mônica ou Pampers, tamanhos M ou G).

Contamos também com sua contribuição de R$10,00, para investimento nos comes e bebes do grande evento, que deverá ser paga até o dia 23/07,  a Carolina Dourado, Solange ou Mona.

Ainda teremos outros, em Setembro e Novembro deste ano.

A safra de 2015 já está sendo gestada, com nosso colega Lucas Salles puxando a fila, com previsão para Fevereiro de 2015!

"Oh! Bendito que semeia 
Filhos... filhos à mão cheia... 
E manda a humanidade se renovar!!#" 
(baseado em O Livro e a América - A. F. de Castro Alves)#')

pessoas.push({:t=>"", :c=>cegonhaTxt})
pessoas.push({:t=>"", :c=>babyboomTxt})

birthData = CSV.open("/home/93274300500/lab/boletim/data/aniversariantes_julho.csv", 'r', {:col_sep=>';'})
leaveData = CSV.open("/home/93274300500/lab/boletim/data/ferias_julho.csv",'r', {:col_sep=>';'})

boloImg='<div align="center"><img style="-webkit-user-select: none" src="http://www.brasilescola.com/upload/e/aniversario.jpg"></div>'
pessoas.push({:t=>"", :c=>boloImg})
pessoas.push({:t=>"", :c=>buildBirthdayGuys("julho", birthData)})

feriasImg='<div align="center"><img width="50%" style="-webkit-user-select: none" src="http://rekoba.com.br/wp-content/uploads/2012/12/REKOBA-F%C3%89RIAS-2012.jpg"></div>'
pessoas.push({:t=>"", :c=>feriasImg})
pessoas.push({:t=>"", :c=>buildLeave("julho", leaveData)})

cultura = Array.new
cultura.push({:t=>"<h2>SESSÃO PIPOCA</h2>", :c=>""})

cultura.push({:t=>'Eu e Você ("Io e Te", Itália, 2012) ★★★★', :c=>br('Sinopse: Escondido no porão para passar suas férias de inverno, Lorenzo, um jovem de quatorze anos, introvertido e um pouco neurótico, está se preparando para viver seu grande sonho: nada de conflitos, nada de colegas chatos de classe, nada de brincadeiras e falsidades. O mundo lá fora com suas regras incompreensíveis e ele deitado no sofá, bebendo muita coca-cola, comendo atum em caixinha e com livros de terror ao seu redor. Será Olivia, que chega de repente no porão com sua agressiva vitalidade, a tirar Lorenzo de seu universo sombrio, para que ele tire a máscara de adolescente complicado e aceite o jogo caótico da vida fora de quatro paredes. Dirigido por Bernardo Bertolucci.
Fonte: Blog "Eu e a Telona" (http://eueatelona.blogspot.com.br/2013/10/eu-e-voce-io-e-te-2012.html)')})

expediente = Array.new
expediente.push({:t=>"Expediente"})
expediente.push({:k=>"Chefe de Reportagem", :v=>"Vileide"})
expediente.push({:k=>"Diagramação e Programação", :v=>"Evandro"})
expediente.push({:k=>"Conteúdo e Contribuições", :v=>"Ana Regina, Carlile, Eduardo Tourinho, Evandro, Fabão, Leo Cunha, Lívia Embiruçu, Lucas Rego, Taise, Vanderlei e Vileide"})

renderer = ERB.new(contents)
puts output = renderer.result()
File.write("#{Dir.pwd}/pre.html", output)
premailer = Premailer.new("#{Dir.pwd}/pre.html", :warn_level => Premailer::Warnings::SAFE)

# Write the HTML output
File.open("#{Dir.pwd}/output.html", "w") do |fout|
  fout.puts premailer.to_inline_css
end

# Write the plain-text output
#File.open("#{Dir.pwd}/output.txt", "w") do |fout|
#  fout.puts premailer.to_plain_text
#end

# Output any CSS warnings
premailer.warnings.each do |w|
  puts "#{w[:message]} (#{w[:level]}) may not render properly in #{w[:clients]}"
end

FileUtils.rm("#{Dir.pwd}/pre.html")
exec("firefox #{Dir.pwd}/output.html")
