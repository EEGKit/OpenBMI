%% �� ���α׷��� �κ��� �����δ� ����, ���̷δ� ���͸� ���
%% �κ� �հ����� ��� 0~6800 ������ ���� ������.  
%% Joint position control�̳� cartesian position control�̳� 
%% Joint�� ���� ��ǥ�� �������� �����̳� cartesian�� �����ǥ�� ������ 
%% �Ѵ� ��ǥ ������ ������ �ٷ� �ǵ��ƿ´ٴ� ������ ����
%% �ڵ忡 ���� ���� �ʴ´ٸ� ������ cartesian velocity/joint velocity�� �Ἥ �����̴� ����� ���� ������.
%% �ݺ��Ǵ� �������� ���� ���ȭ�� ������ ����Ǿ�߰ڴ�.
clc; clear; close;

jc = JacoComm;
connect(jc);
calibrateFingers(jc);

%% Query individual object properties
jc.JointPos
%%
jc.JointVel
%%
jc.JointTorque
%%
jc.JointTemp
%%
jc.FingerPos
%%
jc.FingerVel
%%
jc.FingerTorque
%%
jc.FingerTemp
%%
jc.EndEffectorPose
%%
jc.EndEffectorWrench
%%
jc.ProtectionZone
%%
jc.EndEffectorOffset
%%
jc.DOF
%%
jc.TrajectoryInfo

%% Methods to query joint and finger values all at once
%% �� ���� ���� ���� �հ��� ���� ���� ���� ����
pos = getJointAndFingerPos(jc);
%%
%% �� ���� �ӵ� ���� �հ��� ���� �ӵ� ���� ����
vel = getJointAndFingerVel(jc);
%%
%% �� ���� ��ũ ���� �հ��� ���� ��ũ ���� ����
torque = getJointAndFingerTorque(jc);
temp = getJointAndFingerTemp(jc);

setPositionControlMode(jc);
goToHomePosition(jc);

current_pos=jc.EndEffectorPose;
home_pos=jc.EndEffectorPose;
previous_pos=current_pos;

% �ո� ����� �� ���� 5,6,7
% jntVelCmd = [0;0;0;0;0;-0.4;0]; %7DOF
% for i=1:200
%     sendJointVelocityCommand(jc,jntVelCmd);
% end

% limit_x=0.7;
% limit_y=0.7;
% limit_z=1.1;


%home_pos=[0 0 0 0 0 0];
%% Desired_pos�� �۾����� �ٱ��̶�� �ݵ�� ���ܽ��Ѿ� �Ѵ�.
% home_pos=jc.EndEffectorPose;
% current_pos=jc.EndEffectorPose;
% prev_pos=current_pos;
% 
% setPositionControlMode(jc);
% fCmd = 0*ones(3,1);
% sendFingerPositionCommand(jc,fCmd);
% 
% desired_pos=[0.7; -0.25; 0.1; home_pos(4); home_pos(5); home_pos(6)];
% moveToCP(jc,desired_pos);
% 
% 
% pause(1);
% 
% setPositionControlMode(jc);
% fCmd = 6000*ones(3,1);
% sendFingerPositionCommand(jc,fCmd);
% 
% 
% desired_pos=[0.7; -0.2; 0.2; home_pos(4); home_pos(5); home_pos(6)];
% moveToCP(jc,desired_pos);


% Wrist rotation
%  jntVelCmd = [0;0;0;0;0;0;0.8]; %7DOF
%  for i=1:260
%      sendJointVelocityCommand(jc,jntVelCmd);
%  end
% 
%  jntVelCmd = [0;0;0;0;0;0;-0.8]; %7DOF
%  for i=1:260
%      sendJointVelocityCommand(jc,jntVelCmd);
%  end
%  
%  
%  desired_pos=[0.7; -0.25; 0.1; home_pos(4); home_pos(5); home_pos(6)];
% moveToCP(jc,desired_pos);
% 
% pause(1);
% 
% setPositionControlMode(jc);
% fCmd = 0*ones(3,1);
% sendFingerPositionCommand(jc,fCmd);
% 
% 
% 
% desired_pos=[0.2; -0.2; 0.4; home_pos(4); home_pos(5); home_pos(6)];
% moveToCP(jc,desired_pos);
% length=sqrt((desired_pos(1)-current_pos(1)).^2+(desired_pos(2)-current_pos(2)).^2+(desired_pos(3)-current_pos(3)).^2);
% CartVel=0.2;
% direction=CartVel*[desired_pos(1)-current_pos(1),desired_pos(2)-current_pos(2),desired_pos(3)-current_pos(3)]/length;
% time=round(length*200/CartVel);

%time=400;