--���Ҽ���ѧϰ

--�ű���
x713506_g_ScriptId = 713506

--ѧϰ����Ҫ˵�Ļ�
x713506_g_MessageStudy = "�����ﵽ%d�����ҿϻ���#{_EXCHG%d}�Ϳ���ѧ����Ҽ��ܡ������ѧϰô��"

--���ܱ��
x713506_g_AbilityID = ABILITY_FENGREN

--��������
x713506_g_AbilityName = "����"

x713506_g_Name1 = "ľ����"
--**********************************
--������ں���
--**********************************
function x713506_OnDefaultEvent( sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId,bid )
	--��Ҽ��ܵĵȼ�
	AbilityLevel = QueryHumanAbilityLevel(sceneId, selfId, x713506_g_AbilityID)
	--��ҷ��Ҽ��ܵ�������
	ExpPoint = GetAbilityExp(sceneId, selfId, x713506_g_AbilityID)
	--�����ж�

	--�ж��Ƿ��Ѿ�ѧ���˷���,���ѧ����,����ʾ�Ѿ�ѧ����
	if AbilityLevel >= 1 then
		BeginEvent(sceneId)
        	AddText(sceneId,"���Ѿ�ѧ��"..x713506_g_AbilityName.."������");
        	EndEvent(sceneId)
        DispatchMissionTips(sceneId,selfId)
		return
	end

	--�ڳ�����ѧϰ�������
	if bid then
		x713506_StudyInCity(sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId,bid)
		return
	end

	--���������ǡ�ѧϰ���ܡ���������=0��
	if ButtomNum == 0 then
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel, extraMoney, extraExp = LuaFnGetAbilityLevelUpConfig2(ABILITY_FENGREN, 1);
		if ret and ret == 1 then
			BeginEvent(sceneId)
			
			if GetName(sceneId, targetId) == x713506_g_Name1   then
				demandMoney = extraMoney;
			end
			
			local addText = format(x713506_g_MessageStudy, limitLevel, demandMoney);
			AddText(sceneId,addText)
			--ȷ��ѧϰ��ť
					AddNumText(sceneId,x713506_g_ScriptId,"��ȷ��Ҫѧϰ", 6, 2)
			--ȡ��ѧϰ��ť
					AddNumText(sceneId,x713506_g_ScriptId,"��ֻ��������", 8, 3)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		end
	elseif ButtomNum == 2 then			--���������ǡ���ȷ��Ҫѧϰ��
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel, extraMoney, extraExp = LuaFnGetAbilityLevelUpConfig2(ABILITY_FENGREN, 1);
		if ret and ret == 1 then
		
			if GetName(sceneId, targetId) == x713506_g_Name1   then
				demandMoney = extraMoney;
			end

			--�������Ƿ���һ�����ҵ��ֽ�
			if GetMoney(sceneId,selfId)+GetMoneyJZ(sceneId,selfId) < demandMoney then			
				BeginEvent(sceneId)
					AddText(sceneId,"��Ľ�Ǯ����");
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--�����ҵȼ��Ƿ�ﵽҪ��
			if GetLevel(sceneId,selfId) < limitLevel then
				BeginEvent(sceneId)
					AddText(sceneId,"��ĵȼ�����");
					EndEvent(sceneId)
				DispatchMissionTips(sceneId,selfId)
				return
			end
			--ɾ����Ǯ
			LuaFnCostMoneyWithPriority(sceneId,selfId,demandMoney)
			--����������1
			SetHumanAbilityLevel(sceneId,selfId,x713506_g_AbilityID,1)
			--��npc���촰��֪ͨ����Ѿ�ѧ����
			BeginEvent(sceneId)
				AddText(sceneId,"��ѧ����"..x713506_g_AbilityName.."����")
			EndEvent( )
			LuaFnAuditLearnLifeAbility(sceneId,selfId,x713506_g_AbilityID)
			DispatchEventList(sceneId,selfId,targetId)
		end
	else --����������ֻ����������
		CallScriptFunction( g_Npc_ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
	end
end

--**********************************
--�о��¼�
--**********************************
function x713506_OnEnumerate( sceneId, selfId, targetId, bid )
		if bid then
			local ret = CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck",sceneId, selfId, x713506_g_AbilityID, bid, 5)
			if ret > 0 then AddNumText(sceneId,x713506_g_ScriptId,"ѧϰ"..x713506_g_AbilityName.."����", 12, 0) end
			return
		end
		--��������ȼ�����ʾѡ��
		--if GetLevel(sceneId,selfId) >= LEVELUP_ABILITY_FENGREN[1].HumanLevelLimit then
		local ret, demandMoney, demandExp, limitAbilityExp, limitAbilityExpShow, currentLevelAbilityExpTop, limitLevel = LuaFnGetAbilityLevelUpConfig(ABILITY_FENGREN, 1);
		--if ret and ret == 1 and GetLevel(sceneId,selfId) >= limitLevel then
		if ret and ret == 1 then
			AddNumText(sceneId,x713506_g_ScriptId,"ѧϰ"..x713506_g_AbilityName.."����", 12, 0)
		end
		return
end

--**********************************
--����������
--**********************************
function x713506_CheckAccept( sceneId, selfId )
end

--**********************************
--����
--**********************************
function x713506_OnAccept( sceneId, selfId, x713506_g_AbilityID )
end

--�ڳ�����ѧϰ�������ʱ��Ҫִ�еĺ���
function x713506_StudyInCity(sceneId, selfId, targetId, ButtomNum,g_Npc_ScriptId,bid)
	if bid then
		if 0 == ButtomNum then
			--�������Ƿ��ڵ�ά��״̬
			if CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "CheckCityStatus",sceneId, selfId,targetId) < 0 then
				return
			end
			--����������ʾ����
			BeginEvent(sceneId)
			local lv,money,con
			lv,money,con = CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnCityAction",sceneId, selfId, targetId, x713506_g_AbilityID, bid, 4)
			local studyMsg = format("�����ﵽ%d�����ҿϻ���#{_EXCHG%d}��%d��ﹱ�Ϳ���ѧ��"..x713506_g_AbilityName.."���ܡ������ѧϰô��", lv, money, con)
			AddText(sceneId,studyMsg)
			--ȷ��ѧϰ��ť
					AddNumText(sceneId,x713506_g_ScriptId,"��ȷ��Ҫѧϰ", 6, 2)
			--ȡ��ѧϰ��ť
					AddNumText(sceneId,x713506_g_ScriptId,"��ֻ��������", 8, 3)
			EndEvent(sceneId)
			DispatchEventList(sceneId,selfId,targetId)
		elseif 2 == ButtomNum then
			local ret = CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnCityCheck",sceneId, selfId, x713506_g_AbilityID, bid, 1)
			if ret > 0 then
				CallScriptFunction( CITY_BUILDING_ABILITY_SCRIPT, "OnCityAction",sceneId, selfId, targetId, x713506_g_AbilityID, bid, 1)
			end
		else
			CallScriptFunction( g_Npc_ScriptId, "OnDefaultEvent",sceneId, selfId, targetId )
		end
	end
end