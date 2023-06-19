# Battle Line Effect

####새로운 라인 이펙트를 만들 때
1. 'Resources/Battle/Effect/effect_line/effect_m00000_skill01_laser' 폴더를 복제(Duplicate)한 후 적절한 이름으로 변경해주세요.
2. 'BattleEffectTool'(이하 이펙트툴) 씬을 열고 기존에 있던 라인이펙트를 삭제 한후 새로운 라인 이펙트를 하이러키에 추가해 주세요.
3. 하이러키의 'BattleEffectToolManager'를 선택한 후 추가된 라인 이펙트를 'Line Effect'에 할당해주세요.

---

###라인 이펙트 기능/설명
- 필요한 라인렌더러 수만큼 'line_#' 오브젝트를 복제한 후 'LineEffectRenderers'에 추가해주세요.(2020.05.13 추가)
- 타일링(x)을 제외한 라인의 비쥬얼은 'line_#' 게임 오브젝트의 'CommonEffectController'를 이용하여 조정해주세요.(2020.05.13 수정)
- 타일링(x)은 'BattleLineEffectRenderer'의 각 tile 변수를 이용하여 조정해주세요(플레이 모드에서 수치를 바꿔가면서 조정, 이후 에디트 모드에 해당 값 적용)(2020.05.13 수정)
- 필요에 따라 'Animator'를 사용해주세요.
- 라인 전체를 포함하는 파티클(쉐이프:박스,메쉬)를 사용해야 할 경우 'wrapper_centereffect'안에 이펙트를 만들어주시고 'BattleLineEffect'의 'DistanceParticles'에 추가해주세요.
- 라인의 시작과 끝에 이펙트가 추가되어야 할 경우 'wrapper_starteffect', 'wrapper_endeffect' 폴더에 넣어주시고 이펙트의 방향은 폴더안의 화살표를 참고해주세요.(화살표는 위를 가리키고 있는 이미지입니다) 

---

###완성된 라인 이펙트를 인게임에서 확인하려면
- 라인이펙트는 스킬초기화시 코드안에서 생성되어 이후 여러번 재사용하는 형태로 사용됩니다.
- 따라서 이펙트 완성여부를 각 이펙트를 사용하는 캐릭터의 클라이언트 작업자(2020년 4월 10일기준 쿠키(권기동), 몬스터(김준학))에게 알려 적용하도록 해 주세요.

---

작성자/문의 : junhak.kim@devsisters.com
