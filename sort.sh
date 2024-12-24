#!/bin/bash

# 입력 파일과 출력 파일
INPUT_FILE="input.txt"
OUTPUT_FILE="output.txt"

# 연속된 중복만 제거
sort "$INPUT_FILE" | uniq > "$OUTPUT_FILE"

echo "연속된 중복 제거 완료. 결과는 $OUTPUT_FILE에 저장되었습니다."
