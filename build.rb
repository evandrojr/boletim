#!/usr/bin/env ruby 
#encoding UTF-8

require 'erb'
require 'csv'
require 'fileutils'
require "#{Dir.pwd}/aniversariantes.rb"
require "#{Dir.pwd}/ferias.rb"
require 'premailer'
require 'nokogiri'
require 'rubygems'

meses=Hash.new
meses['01']="janeiro"
meses['07']="julho"
meses['08']="agosto"

dataPorExtenso = DateTime.now.strftime('%d de ' + meses[DateTime.now.strftime('%m')] + ' de %Y')

template = File.read("#{Dir.pwd}/clean.erb")
content = File.read("#{Dir.pwd}/conteudo.xml")

def br(text)
  return "" if ! filled? (text)
  text = text.gsub(/\r/,"")
  text = text.gsub(/\n/,"<BR>")
end

def clean(text)
  text = text.gsub(/^ /,"")
  text = text.gsub(/ $/,"")
  text = text.gsub(/^\n/,"")
  text = text.gsub(/\n$/,"")
  text = text.gsub(/^ /,"")
  text = text.gsub(/ $/,"")
end

def csvToArray(v)
    v=v.split("\n")
    a = Array.new
#    puts v.inspect
    v.each{ |l|
      a.push l.split(';')
    }
    return a
end

def filled?(v)
  return false if ! defined? v
  return false if v.nil?
  return false if v.empty? 
  true
end


def r(v)
  begin
    v = $doc.xpath(v)[0].content
  rescue
    return ""
  end
  return v
end

def rb(v, sec)
  sec = Array.new if ! filled? sec
  h = Hash.new
  $doc.xpath(v).each do |n|
     h = {:t=>br(n['titulo']), :st=>br(n['subtitulo']), :c=>br(n.content)} 
     sec.push(h)
  end
  return sec
end

$doc = doc = Nokogiri::XML(content)
boletimNumero = doc.xpath('//boletim')[0]['numero']
editorial=rb('//boletim/editorial', editorial)
servicos = rb('//boletim/servicos', servicos)
eventos = rb('//boletim/eventos', eventos)
mudancas = rb('//boletim/mudancas', mudancas)
pessoas = rb('//boletim/pessoas', pessoas)
cultura = rb('//boletim/cultura', cultura)
expediente = rb('//boletim/expediente', expediente)

aniversariantes = csvToArray(clean(r('//boletim/aniversariantes')))
ferias = csvToArray(clean(r('//boletim/ferias')))

if filled? aniversariantes 
  boloImg='<div align="center"><img style="-webkit-user-select: none" src="http://www.brasilescola.com/upload/e/aniversario.jpg"></div>'
  pessoas.push({:t=>"", :c=>boloImg})
  pessoas.push({:t=>"", :c=>buildBirthdayGuys(meses[DateTime.now.strftime('%m')], aniversariantes)})
end  

if filled? ferias
  feriasImg='<div align="center"><img width="50%" style="-webkit-user-select: none" src="http://rekoba.com.br/wp-content/uploads/2012/12/REKOBA-F%C3%89RIAS-2012.jpg"></div>'
  pessoas.push({:t=>"", :c=>feriasImg})
  pessoas.push({:t=>"", :c=>buildLeave(meses[DateTime.now.strftime('%m')], ferias)})
end

renderer = ERB.new(template)
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

