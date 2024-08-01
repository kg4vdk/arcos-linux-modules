#!/bin/bash

# Phonetic Alaphabet
if [ ! -z "$1" ]; then
        LENGTH=${#1}
        COUNTER=0
        until [ "$COUNTER" -ge "$LENGTH" ] ; do
        STR=${1:$COUNTER:1}
        case $STR in

                A)      OUTPUT="$OUTPUT ALPHA"
                ;;
                B)      OUTPUT="$OUTPUT BRAVO"
                ;;
                C)      OUTPUT="$OUTPUT CHARLIE"
                ;;
                D)      OUTPUT="$OUTPUT DELTA"
                ;;
                E)      OUTPUT="$OUTPUT ECHO"
                ;;
                F)      OUTPUT="$OUTPUT FOXTROT"
                ;;
                G)      OUTPUT="$OUTPUT GOLF"
                ;;
                H)      OUTPUT="$OUTPUT HOTEL"
                ;;
                I)      OUTPUT="$OUTPUT INDIA"
                ;;
                J)      OUTPUT="$OUTPUT JULIET"
                ;;
                K)      OUTPUT="$OUTPUT KILO"
                ;;
                L)      OUTPUT="$OUTPUT LIMA"
                ;;
                M)      OUTPUT="$OUTPUT MIKE"
                ;;
                N)      OUTPUT="$OUTPUT NOVEMBER"
                ;;
                O)      OUTPUT="$OUTPUT OSCAR"
                ;;
                P)      OUTPUT="$OUTPUT PAPA"
                ;;
                Q)      OUTPUT="$OUTPUT QUEBEC"
                ;;
                R)      OUTPUT="$OUTPUT ROMEO"
                ;;
                S)      OUTPUT="$OUTPUT SIERRA"
                ;;
                T)      OUTPUT="$OUTPUT TANGO"
                ;;
                U)      OUTPUT="$OUTPUT UNIFORM"
                ;;
                V)      OUTPUT="$OUTPUT VICTOR"
                ;;
                W)      OUTPUT="$OUTPUT WHISKEY"
                ;;
                X)      OUTPUT="$OUTPUT X-RAY"
                ;;
                Y)      OUTPUT="$OUTPUT YANKEE"
                ;;
                Z)      OUTPUT="$OUTPUT ZULU"
                ;;
                1)      OUTPUT="$OUTPUT ONE"
                ;;
                2)      OUTPUT="$OUTPUT TWO"
                ;;
                3)      OUTPUT="$OUTPUT THREE"
                ;;
                4)      OUTPUT="$OUTPUT FOUR"
                ;;
                5)      OUTPUT="$OUTPUT FIVE"
                ;;
                6)      OUTPUT="$OUTPUT SIX"
                ;;
                7)      OUTPUT="$OUTPUT SEVEN"
                ;;
                8)      OUTPUT="$OUTPUT EIGHT"
                ;;
                9)      OUTPUT="$OUTPUT NINE"
                ;;
                0)      OUTPUT="$OUTPUT ZERO"

        esac
        let COUNTER+=1
        done

OUTLEN=${#OUTPUT}
echo "${OUTPUT:1:$OUTLEN}"
fi
