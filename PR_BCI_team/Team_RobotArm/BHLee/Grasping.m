function Grasping_and_Twisting

%% Grasping and twisting

clear; close; clc;
%% initiate
bbci_acquire_bv('close');
startup_bbci;

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


setPositionControlMode(jc);
fCmd = 0*ones(3,1);
sendFingerPositionCommand(jc,fCmd);

%% EEG_Mat file ���� �غ�
global EEG_MAT_DIR
EEG_MAT_DIR = '';

dd = 'MotorImagery Converted Data\';
filelist= {'20191113_demo_bhkwon'};

%%
Bandpass_Filter = [8 24]; % ��� ���� ���� ��Ȯ������ ���ؾ���.

% ----------------------------------------------------------------------
% Offline Classifier Training
[cnt, mrk, mnt] = eegfile_loadMatlab([dd filelist{1}]);

ival = [0 3000];

cnt_filt = proc_filtButter(cnt, 5, Bandpass_Filter);
epo = cntToEpo(cnt_filt,mrk,ival);

[fv, Out.csp_w]=  proc_multicsp(epo, 3);
fv = proc_variance(fv); fv= proc_logarithm(fv);

fv.classifier_param = {'RLDAshrink','prior', nan, 'store_prior', 1, 'store_means', 1, ...
    'store_cov', 1, 'store_invcov', 1, 'scaling', 1};

proc = {'wr_multiClass','policy','one-vs-all','coding','hamming'}; % one-vs-all all-pairs

Out.C = trainClassifier(fv, proc);
Out.out_eeg = applyClassifier(fv, 'wr_multiClass', Out.C);