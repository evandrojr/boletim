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

editorial = ""
homologacoes=""
reunioes=""
realizacoes=""
viagens=""
novidades=""

editorial = Array.new
editorialTexto = br("Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna.
Sed consequat, leo eget bibendum sodales, augue velit cursus nunc")
editorial.push({:t=>"Existe vida após a copa!", :c=>editorialTexto})
  
homologacoes=br("SIGEPE-GED-AFD - Validação
Data: 07/07/2014
Objetivo: Validar a iteração 4 do SIGEPE-GED-AFD
Responsável: Vanderlei Souza

SIGEPE-PA - Validação
Data: 14/07/2014
Objetivo: Validar a iteração 7 do SIGEPE - Pensão Alimentícia
Responsável: Cezar Ronaldo

SIGEPE-Consignações - Validação
Data: 22/07/2014
Objetivo: Validar a iteração 5 da release 1.1 do SIGEPE-Consignações
Responsável: Sandro Almeida 

PGDITR - Equipe DE509
Período: 21 a 25/07/2014.
Objetivo: Homologar o PGDITR 2014
Responsável: Taise")

reunioes=br("SIGEPE-Consignações - Inception do módulo Denúncias
Data: 20 a 22/07/2014
Objetivo: Realizar o evento de inception para levantar e priorizar o backlog do módulo Denúncias do SIGEPE-Consignações
Responsável: Sandro Almeida")

realizacoes=br("A equipe e-Processo implantou, no último dia 27/06, quatro projetos que abrangem manutenções evolutivas no sistema, a saber:
- e-PROCESSO-135021 - CODAC 0622/2013- Atualizar Palavras Chave na Movimentação de Processos entre Tipo de Unidades Diferentes;
- e-PROCESSO-86010 - CODAC 0397/2013 - Inclusão de Subtipos de Dossiês e de Tipos de Documentos;
- e-PROCESSO-135037 - CODAC 0574/2013 - Dispensar DTE na Realização de Ciência do Tipo Comunicado;
e-PROCESSO-54060 - CODAC 1056/2012 - Solicitação de Juntada de Documentos.

Outras implantações estão em planejamento, retomando o fluxo de entrega da equipe, após um período de instabilidade do sistema, decorrente de problemas de ambiente e acréscimo da quantidade de usuários que o utilizam.")

viagens=br("- Lucas Carvalho Rego

Objetivo: Participar da reunião de integração do módulo de julgamento entre os sistemas SIEF-Processos e e-Processo.
Período: 15/07/2014 a 18/07/2014.
Local: São Paulo (Serpro/Socorro)")

cegonha=br("<div align='center'><img src='http://voce.serpro/articles/0106/3070/turma_da_cegonha.jpeg' height='197' width='197'></div>
Lucas Salles é o primeiro confirmado como Papai 2015, com previsão para Fevereiro. Como ainda está cedo, não sabemos o sexo.
Rogério Reis está esperando uma menina com o nome de Ananda.")

babyboom=br('<div align="center"><img id="irc_mi" src="http://www.petitepalate.com/pp/images/babies.jpg" width="668" height="180" "></div>
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
E manda a humanidade se renovar!!" 
(baseado em O Livro e a América - A. F. de Castro Alves)')

pessoas = Array.new
pessoas.push({:t=>"", :c=>cegonha})
pessoas.push({:t=>"", :c=>babyboom})

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

cultura.push({:t=>'Eu e Você ("Io e Te", Itália, 2012)', :c=>br('Sinopse: Escondido no porão para passar suas férias de inverno, Lorenzo, um jovem de quatorze anos, introvertido e um pouco neurótico, está se preparando para viver seu grande sonho: nada de conflitos, nada de colegas chatos de classe, nada de brincadeiras e falsidades. O mundo lá fora com suas regras incompreensíveis e ele deitado no sofá, bebendo muita coca-cola, comendo atum em caixinha e com livros de terror ao seu redor. Será Olivia, que chega de repente no porão com sua agressiva vitalidade, a tirar Lorenzo de seu universo sombrio, para que ele tire a máscara de adolescente complicado e aceite o jogo caótico da vida fora de quatro paredes. Dirigido por Bernardo Bertolucci.
Fonte: Blog "Eu e a Telona" (http://eueatelona.blogspot.com.br/2013/10/eu-e-voce-io-e-te-2012.html)')})

cultura.push({:t=>'Taxi Driver (EUA, 1976)', :c=>br('Sinopse: Em Nova York, um homem de 26 anos (Robert De Niro), veterano da Guerra do Vietnã, é um solitário no meio da grande metrópole que ele vagueia noite adentro. Assim começa a trabalhar como motorista de taxi no turno da noite e nele vai crescendo um sentimento de revolta pela miséria, o vício, a violência e a prostituição que estão sempre à sua volta. Após comprar armas, ele articula um atentado contra o senador (que planeja ser presidente). Dirigido por Martin Scorsese.
Fonte: Blog "Eu e a Telona" (http://eueatelona.blogspot.com.br/2014/06/taxi-driver-eua-1976.html)')})

cultura.push({:t=>'Bad Words (EUA, 2013)', :c=>br('Guy Trilby (Jason Bateman) é um adulto frustrado, que nunca venceu os concursos para soletrar palavras quando era pequeno. No entanto, já adulto, ele descobre uma brecha no regulamento permitindo que ele concorra contra as crianças de 10 anos de idade. Agora, contra a vontade de todos os participantes, Guy terá uma segunda oportunidade de levar o troféu.
Fonte: Adoro Cinema (http://www.adorocinema.com/filmes/filme-210042/)')})


expediente = Array.new
expediente.push({:t=>"Expediente"})
expediente.push({:k=>"Diretora Editorial", :v=>"Vileide"})
expediente.push({:k=>"Diagramação e Programação", :v=>"Evandro"})
expediente.push({:k=>"DE Cultura", :v=>"Vanderlei & Evandro"})

renderer = ERB.new(contents)
puts output = renderer.result()
File.write("#{Dir.pwd}/boletim.html", output)

FileUtils.copy("#{Dir.pwd}/boletim.html", "/var/www/boletim.html")

premailer = Premailer.new('http://localhost/boletim.html', :warn_level => Premailer::Warnings::SAFE)

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

exec("firefox #{Dir.pwd}/output.html")
