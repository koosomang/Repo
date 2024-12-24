#!/bin/bash

# Quay API 정보
QUAY_API="https://quay.io/api/v1/repository"
ACCESS_TOKEN="<ACCESS_TOKEN>"  # Quay 인증 토큰
NEXT_PAGE="$QUAY_API"
ALL_REPOS=()

# 페이지네이션을 처리하여 모든 레포지토리 가져오기
while [ -n "$NEXT_PAGE" ]; do
  RESPONSE=$(curl -s -L -H "Authorization: Bearer $ACCESS_TOKEN" "$NEXT_PAGE")
  
  # 현재 페이지의 레포지토리 추가
  REPOS=$(echo "$RESPONSE" | jq -r '.repositories[] | .namespace + "/" + .name')
  ALL_REPOS+=($REPOS)
  
  # 다음 페이지 URL 설정
  NEXT_PAGE=$(echo "$RESPONSE" | jq -r '.next_page')
  
  # 다음 페이지가 없으면 종료
  if [ "$NEXT_PAGE" == "null" ]; then
    NEXT_PAGE=""
  fi
done

# 결과 출력
echo "Total Repositories:"
for REPO in "${ALL_REPOS[@]}"; do
  echo "$REPO"
done
