#!/bin/bash

# Cores
verde="\e[1;32m"
vermelho="\e[1;31m"
azul="\e[1;34m"
branco="\e[1;37m"
amarelo="\e[1;33m"
cinza="\e[0;37m"
reset="\e[0m"

clear
echo -e "${azul}======================================================="
echo -e "        SISTEMA DE CLONAGEM DE WHATSAPP ${amarelo}by alisonkkjj yt${reset}"
echo -e "=======================================================${reset}"
echo

read -p "Digite o número alvo (DDD + número, ex: 45987512345): " numero

# Formatar número para exibir (DDD + 9 dígitos)
ddd="${numero:0:2}"
parte1="${numero:2:5}"
parte2="${numero:7:4}"
numero_formatado="(+55) (${ddd}) ${parte1}-${parte2}"

# Lista dos DDDs da região para sortear (exemplo Sul do Brasil)
ddds_regionais=(41 42 43 44 45 46 47 48 49)

# Mensagens neutras, variadas, com gírias e erros, muitas linhas pra não repetir fácil
mensagens_texto=(
"vamo q vamo"
"tô na correria"
"cê viu aquilo?"
"blz já tô indo"
"fala aí demorô"
"sussa tô de boa"
"tá ligado"
"pega leve"
"de boa só na paz"
"faz um pix aí"
"tô sem grana"
"já já to lá"
"manda aquela foto"
"bora marcar"
"tá osso hoje"
"tô na rua"
"só espera aí"
"vlw, tamo junto"
"num to podendo agora"
"tipo assim"
"se pá eu passo aí"
"deu ruim aqui"
"nem me fala"
"qual é a boa?"
"que horas chega?"
"já jantei"
"to bolado"
"parou no farol"
"vamo na fé"
"tá tranquilo"
"tô na atividade"
"é nois"
"partiu"
"não deu não"
"qual é a fita?"
"me chama lá"
"responde aí"
"tô de boa na lagoa"
"chega junto"
"firmeza"
"que isso"
"não curti"
"tá suave"
"segura a onda"
"vamo que vamo"
"se liga"
"é nóis na fita"
"passa a visão"
"qual o papo?"
"tá osso aqui"
"tá na hora"
"não vacila"
"já era"
"tá ligado aí?"
"sabe de nada"
"isso aí"
"é isso"
"demorô"
"tá de brincadeira"
"vem tranquilo"
"deixa quieto"
"tô morto de cansaço"
"manda áudio"
"chegou aí?"
"tá longe"
"quero ver"
"na moral"
"se cuida"
"foi mal"
"me esqueci"
"tá meio ruim"
"quero almoço"
"to indo já"
"vamo resolver"
"dá um toque"
"já te aviso"
"tá no esquema"
"fica frio"
"to na luta"
"me dá um help"
"que bagulho doido"
"tô pistola"
"tô na pegada"
"to sem tempo"
"pode crer"
"tá ligado no esquema"
"vish, que que rolou?"
"foi mal a demora"
"cadê vc?"
"não tô sabendo"
"manda o endereço"
"tô chegando"
"chama no zap"
"tô de boa aqui"
"vai dar certo"
"tá na hora de sair"
"já tô a caminho"
"vem tranquilo que tá suave"
"só um minutinho"
"tô sem sinal"
"já resolve isso aí"
"tô com fome"
"preciso de um favor"
"manda aí"
"de boa na lagoa"
"tá na paz"
"tá na moral"
"quero sair logo"
"vamo marcar logo"
"tá complicado aqui"
"já volto"
"me espera aí"
"chega junto que é sucesso"
)

tipos_mensagem=("Texto" "Áudio" "Imagem" "Vídeo")

status_msg=("enviado" "entregue" "lido")

prefixos_fixo=(3 4 7)

# Nomes com mais opções comuns e neutros
nomes=("Maria" "João" "Carlos" "Ana" "Marcos" "Fernanda" "Lucas" "Paula" "Ricardo" "Beatriz" "Rafael" "Sofia" "Mãe" "Pai" "Paulo" "Pedro" "Laura" "Gabriel" "Julia" "Carla" "Rosa" "Joana" "José" "Antônio")

declare -A contatos
declare -A combos
declare -a usadas_msg

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

echo
echo -e "${verde}[+] Conectando ao número ${branco}${numero_formatado}${reset}"
echo -e "${amarelo}[i] Processando, aguarde 150 segundos...${reset}"
sleep 150

criar_contatos

gerar_horario() {
    h=$((8 + RANDOM % 15))
    m=$((RANDOM % 60))
    printf "%02d:%02d" $h $m
}

pegar_msg_unica() {
    local total=${#mensagens_texto[@]}
    if [[ ${#usadas_msg[@]} -eq $total ]]; then
        usadas_msg=()
    fi
    while :; do
        local idx=$(( RANDOM % total ))
        if [[ ! " ${usadas_msg[*]} " =~ " $idx " ]]; then
            usadas_msg+=($idx)
            echo "${mensagens_texto[$idx]}"
            break
        fi
    done
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

mostrar_mensagem() {
    local num="$1"
    local nome="${contatos[$num]}"
    local hora=$(gerar_horario)
    local tipo_msg=${tipos_mensagem[$RANDOM % ${#tipos_mensagem[@]}]}
    local status=${status_msg[$RANDOM % ${#status_msg[@]}]}
    local texto=""

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
        "Áudio") texto="[Mensagem de voz]" ;;
        "Imagem") texto="[Imagem]" ;;
        "Vídeo") texto="[Vídeo]" ;;
    esac

    if [[ "$status" == "lido" ]]; then
        msg_cor="${azul}"
    else
        msg_cor="${branco}"
    fi

    echo -ne "${amarelo}${nome} está digitando...${reset}\r"
    sleep 1
    echo -ne "\r                          \r"

    echo -e "${cinza}[$hora]${reset} ${verde}$nome ${msg_cor}$num${reset}: ${msg_cor}$texto ${amarelo}(${tipo_msg}, ${status})${reset}"
}

contador=0

while true; do
    keys=("${!contatos[@]}")
    selecionado=${keys[$RANDOM % ${#keys[@]}]}
    mostrar_mensagem "$selecionado"
    ((contador++))
    echo -ne "${cinza}Mensagens exibidas: $contador${reset}\r"
    sleep_time=$(awk -v min=0.2 -v max=0.6 'BEGIN{srand(); print min+rand()*(max-min)}')
    sleep $sleep_time
done


