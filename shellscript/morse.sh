#!/bin/bash
# ----------------------------------------------------------------------------
# Converte um texto para código morse.
# Uso: adicione a permissão de execução com chmod +x morse.sh
# e chame o script com ./morse.sh "texto a ser traduzido"
# Ex.: ./morse.sh "meu texto aqui"
# Saída: -- . ..-   - . -..- - ---   .- --.- ..- .. 
#
# Autor: Rômulo Pinheiro Costa
# Desde: 2021-07-25
# Versão: 1
# Tags: texto, conversão
# ----------------------------------------------------------------------------

morse() {
  declare -A local codigo_morse

  # Converte o texto do usuario para minusculas pois é necessário 
  # para funcionar com o array associativo
  local entrada="${1,,}"  
  local total_caracteres=${#entrada}
  local posicao=0

  codigo_morse=(
    [a]=".-"   [b]="-..."  [c]="-.-."  [d]="-..."  [e]="."  [f]="..-."
    [g]="--."  [h]="...."  [i]=".."  [j]=".---"  [k]="-.-"  [l]=".-.."
    [m]="--"  [n]="-."  [o]="---"  [p]=".--."  [q]="--.-"  [r]=".-."
    [s]="..."  [t]="-"  [u]="..-"  [v]="...-"  [w]=".--"  [x]="-..-"
    [y]="-.--"  [z]="--.."
    ['0']="-----"  ['1']=".----"  ['2']="..---"  ['3']="...--"  ['4']="....-"
    ['5']="....."  ['6']="-...."  ['7']="--..."  ['8']="---.."  ['9']="----."
    ['.']=".-.-.-"  [',']="--..--"  ['?']="..--.."  ["'"]=".----."
    ['!']="-.-.--"  ['/']="-..-."  ['(']="-.--."  [')']="-.--.-"
    ['&']=".-..."  [':']="---..."  [';']="-.-.-."  ['=']="-...-"
    ['+']=".-.-."  ['-']="-....-"  ['_']="..--.-"  ['"']=".-..-."
    ['$']="...-..-"  ['@']=".--.-."
  )
  

  # para cada caractere do texto informado...
  while test $posicao -lt $total_caracteres
  do
    local caractere=${entrada:$posicao:1}
    
    # Verifica se é um espaço 
    if test "${codigo_morse[$caractere]}" = " "; 
    then
      # imprime o espaço
      printf " "
    else
      # Se houver tradução para o morse...
      if test ${codigo_morse[$caractere]}
      then
        # substitui cada caractere da frase pelo respectivo código
        printf "%s " "${codigo_morse[$caractere]}";
      else
        #se não, imprime o caractere em maiúsculas
        printf "%s " "${caractere^}"
      fi
    fi
    posicao=$((posicao + 1))
  done
  printf "\n"

}

morse "$1"
