#!/bin/bash

# Cores
verde="\e[1;32m"
vermelho="\e[1;31m"
azul="\e[1;34m"
amarelo="\e[1;33m"
cinza="\e[0;37m"
branco="\e[1;37m"
reset="\e[0m"

# Cabeçalho colorido
clear
echo -e "${azul}  ____  _     ___ ____ ___ ___  _   _ ${reset}"
echo -e "${amarelo} / ___|| |   |_ _/ ___|_ _/ _ \\| \\ | |${reset}"
echo -e "${azul} \\___ \\| |    | | |    | | | | |  \\| |${reset}"
echo -e "${amarelo}  ___) | |___ | | |___ | | |_| | |\\  |${reset}"
echo -e "${azul} |____/|_____|___\\____|___\\___/|_| \\_|${reset}"
echo
echo -e "${amarelo}SISTEMA DE CLONAGEM DE WHATSAPP${reset}"
echo -e "${vermelho}              by alisonkkjj yt${reset}"
echo

read -p "Digite o número alvo (DDD + número, ex: 45987512345): " numero

ddd="${numero:0:2}"
parte1="${numero:2:5}"
parte2="${numero:7:4}"
numero_formatado="(+55) (${ddd}) ${parte1}-${parte2}"

gera_seed() {
    local str="$1"
    local sum=0
    for (( i=0; i<${#str}; i++ )); do
        sum=$(( sum + $(printf "%d" "'${str:i:1}") ))
    done
    echo $sum
}

seed=$(gera_seed "$numero")
RANDOM=$seed

ddds_regionais=(41 42 43 44 45 46 47 48 49)

mensagens_texto=(
"vamo q vamo" "vamo que vamo" "tô na correria" "cê viu aquilo?" "blz já tô indo" "fala aí demorô"
"sussa tô de boa" "tá ligado" "pega leve" "de boa só na paz" "faz um pix aí" "tô sem grana"
"já já to lá" "manda aquela foto" "bora marcar" "tá osso hoje" "tô na rua" "só espera aí"
"vlw, tamo junto" "num to podendo agora" "tipo assim" "se pá eu passo aí" "deu ruim aqui"
"nem me fala" "qual é a boa?" "que horas chega?" "já jantei" "to bolado" "parou no farol"
"vamo na fé" "tá tranquilo" "tô na atividade" "é nois" "partiu" "não deu não" "qual é a fita?"
"me chama lá" "responde aí" "tô de boa na lagoa" "chega junto" "firmeza" "que isso"
"não curti" "tá suave" "segura a onda" "vamo que vamo" "se liga" "é nóis na fita"
"passa a visão" "qual o papo?" "tá osso aqui" "tá na hora" "não vacila" "já era" "tá ligado aí?"
"sabe de nada" "isso aí" "é isso" "demorô" "tá de brincadeira" "vem tranquilo" "deixa quieto"
"tô morto de cansaço" "manda áudio" "chegou aí?" "tá longe" "quero ver" "na moral" "se cuida"
"foi mal" "me esqueci" "tá meio ruim" "quero almoço" "to indo já" "vamo resolver" "dá um toque"
"já te aviso" "tá no esquema" "fica frio" "to na luta" "me dá um help" "que bagulho doido"
"tô pistola" "tô na pegada" "to sem tempo" "pode crer" "tá ligado no esquema" "vish, que que rolou?"
"foi mal a demora" "cadê vc?" "não tô sabendo" "manda o endereço" "tô chegando" "chama no zap"
"tô de boa aqui" "vai dar certo" "tá na hora de sair" "já tô a caminho" "vem tranquilo que tá suave"
"só um minutinho" "tô sem sinal" "já resolve isso aí" "tô com fome" "preciso de um favor"
"manda aí" "de boa na lagoa" "tá na paz" "tá na moral" "quero sair logo" "vamo marcar logo"
"tá complicado aqui" "já volto" "me espera aí" "chega junto que é sucesso" "me chama no direct"
"tá difícil de acreditar" "sem estresse" "não esquenta" "tá tudo certo" "tô de boa na paz"
"vamos agilizar isso aí" "manda o link" "vou passar aí" "fala com ele" "fica tranquilo" "tô na moral"
"me liga depois" "tô tentando resolver" "já tá no corre" "não deu nada" "to quase chegando"
"qualquer coisa avisa" "tô no ponto" "já sei" "na boa" "tá bom pra você?" "manda aquele áudio"
"tá ficando tarde" "já tô cansado" "deixa eu ver" "tá no esquema" "não vai dar não" "tô de olho"
"segura essa" "deixa pra lá" "não tô afim" "tá osso demais" "vamo ver no que dá" "chega mais"
)

audios=(
"Mensagem de voz - 0:12" "Gravação - 0:05" "Nota de áudio - 0:09" "Áudio rápido - 0:15" "Áudio longo - 0:23"
)

imagens=(
"Foto de praia.jpg" "Selfie engraçada.png" "Print do grupo.jpeg" "Foto do rolê.png" "Imagem engraçada.jpg"
)

videos=(
"Vídeo - Aniversário 2023.mp4" "Clipes engraçados.mp4" "Vídeo do rolê.mp4" "Filmagem do jogo.mp4" "Vídeo curto.mp4"
)

status_msg=("enviado" "entregue" "lido")

prefixos_fixo=(3 4 7)

nomes=("Maria" "João" "Carlos" "Ana" "Marcos" "Fernanda" "Lucas" "Paula" "Ricardo" "Beatriz" "Rafael" "Sofia" "Mãe" "Pai" "Paulo" "Pedro" "Laura" "Gabriel" "Julia" "Carla" "Rosa" "Joana" "José" "Antônio" "Nina" "Léo" "Gui" "Tati" "Bia" "Duda")

declare -A contatos
declare -A combos
declare -a usadas_msg
mensagens_embaralhadas=()

embaralhar_mensagens() {
    mensagens_embaralhadas=($(shuf -e "${mensagens_texto[@]}"))
}

pegar_msg_unica() {
    if [ ${#mensagens_embaralhadas[@]} -eq 0 ]; then
        embaralhar_mensagens
    fi
    msg="${mensagens_embaralhadas[0]}"
    mensagens_embaralhadas=("${mensagens_embaralhadas[@]:1}")
    echo "$msg"
}

criar_contatos() {
    for i in $(seq 1 20); do
        num=$(gerar_numero)
        nome=${nomes[$RANDOM % ${#nomes[@]}]}
        contatos["$num"]="$nome"
    done
}

gerar_numero() {
    local tipo=$(( RANDOM % 2 ))
    local ddd_local=${ddds_regionais[$RANDOM % ${#ddds_regionais[@]}]}
    if [[ $tipo -eq 1 ]]; then
        parte1=$(( 1000 + RANDOM % 9000 ))
        parte2=$(( 1000 + RANDOM % 9000 ))
        echo "+55 $ddd_local 9${parte1}-${parte2}"
    else
        prefix=${prefixos_fixo[$RANDOM % ${#prefixos_fixo[@]}]}
        parte1=$(( 100 + RANDOM % 900 ))
        parte2=$(( 1000 + RANDOM % 9000 ))
        echo "+55 $ddd_local ${prefix}${parte1}-${parte2}"
    fi
}

barra_progresso() {
    local tempo=$1
    local i=0
    local barra=""
    echo -ne "${verde}Iniciando clonagem... Aguarde ${tempo}s...${reset}\n"
    while [ $i -lt $tempo ]; do
        sleep 1
        ((i++))
        barra="${barra}▒"
        echo -ne "\r${verde}[${barra}] ${i}s/${tempo}s${reset} "
    done
    echo -e "\n"
}

echo
echo -e "${verde}[+] Conectando ao número ${branco}${numero_formatado}${reset}"
barra_progresso 90

criar_contatos

gerar_horario() {
    local hora_atual=$(TZ=America/Sao_Paulo date +%H)
    local min_atual=$(TZ=America/Sao_Paulo date +%M)
    local base=8
    local max_hora=22
    (( hora_atual < base )) && hora_atual=$base
    (( hora_atual > max_hora )) && hora_atual=$max_hora
    local hora=$(( base + RANDOM % (hora_atual - base + 1) ))
    local minuto=$(( RANDOM % 60 ))
    printf "%02d:%02d" $hora $minuto
}

get_mensagem_combo() {
    local ultima_msg="$1"
    local proxima_msg=""

    case "$ultima_msg" in
        *"me manda o pix"*)
            proxima_msg="transferência feita"
            ;;
        *"entra no link que te mandei"*)
            proxima_msg="tô esperando"
            ;;
        *"já saiu do trabalho?"*)
            proxima_msg="já chegou em casa?"
            ;;
        *"vamo que vamo"*)
            proxima_msg="tamo junto"
            ;;
        *"fala aí demorô"*)
            proxima_msg="demorô"
            ;;
        *"bora marcar"*)
            proxima_msg="já já to lá"
            ;;
        *"manda aquela foto"*)
            proxima_msg="chegou aí?"
            ;;
        *"tá osso hoje"*)
            proxima_msg="segura a onda"
            ;;
        *)
            proxima_msg=""
            ;;
    esac

    echo "$proxima_msg"
}

imprimir_maquina_escrever() {
    local texto="$1"
    local delay=0.04
    for (( i=0; i<${#texto}; i++ )); do
        echo -n "${texto:$i:1}"
        sleep $delay
    done
}

mostrar_mensagem() {
    local num="$1"
    local nome="${contatos[$num]}"
    local hora=$(gerar_horario)

    local rand_tipo=$(( RANDOM % 100 ))
    local tipo_msg=""
    if (( rand_tipo < 70 )); then
        tipo_msg="Texto"
    elif (( rand_tipo < 95 )); then
        if (( RANDOM % 2 == 0 )); then
            tipo_msg="Áudio"
        else
            tipo_msg="Imagem"
        fi
    else
        tipo_msg="Vídeo"
    fi

    local status=${status_msg[$RANDOM % ${#status_msg[@]}]}
    local texto=""
    local reacao=""

    if [[ -n "${combos[$num]}" ]]; then
        texto="${combos[$num]}"
        unset combos["$num"]
    else
        texto=$(pegar_msg_unica)
        combo_msg=$(get_mensagem_combo "$texto")
        if [[ -n "$combo_msg" ]]; then
            combos["$num"]="$combo_msg"
        fi
    fi

    case "$tipo_msg" in
        "Texto") ;;
        "Áudio") texto="${audios[$RANDOM % ${#audios[@]}]}" ;;
        "Imagem") texto="${imagens[$RANDOM % ${#imagens[@]}]}" ;;
        "Vídeo") texto="${videos[$RANDOM % ${#videos[@]}]}" ;;
    esac

    if [[ "$status" == "lido" ]]; then
        msg_cor="${azul}"
    else
        msg_cor="${branco}"
    fi

    for ret in "" "." ".." "..."; do
        echo -ne "${amarelo}${nome} está digitando${ret}...${reset}\r"
        sleep 0.5
    done
    echo -ne "\r                          \r"

    echo -ne "${cinza}[$hora]${reset} ${verde}$nome ${msg_cor}$num${reset}: "
    imprimir_maquina_escrever "$texto"
    echo -ne " ${amarelo}(${tipo_msg}, ${status})${reset}"

    reacoes=("👍" "😂" "😮" "👏" "🔥" "👌" "")
    reacao=${reacoes[$RANDOM % ${#reacoes[@]}]}
    if [[ -n "$reacao" ]]; then
        echo -e " $reacao"
    else
        echo ""
    fi

    sleep_time=$(awk -v min=1 -v max=3 'BEGIN{srand(); print min+rand()*(max-min)}')
    sleep $sleep_time
}

contador=0

echo -e "\n${verde}Iniciando clonagem...\n${reset}"

while true; do
    keys=("${!contatos[@]}")
    selecionado=${keys[$RANDOM % ${#contatos[@]}]}
    mostrar_mensagem "$selecionado"
    ((contador++))
    echo -ne "${cinza}Mensagens exibidas: $contador${reset}\r"
done










