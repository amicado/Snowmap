// Created by Crowbar 0.49.0.0

$modelname "creeps/roshan/roshan_sfm.mdl"

$bodygroup "default"
{
	studio "roshan_sfm_model.smd"
}
$bodygroup "clamped1"
{
	studio "roshan_sfm_body1_model0.smd"
}


$surfaceprop "default"

$contents "solid"

$maxeyedeflection 90

$cdmaterials "models\creeps\roshan"
$cdmaterials ""

$cbox 0 0 0 0 0 0

$bbox -866.518 -917.151 -43.738 815.001 885.991 1460.337

$bonemerge "Root_0"
$bonemerge "thigh_R"
$bonemerge "Spine_0"
$bonemerge "tail0_0"
$bonemerge "thigh_L"
$bonemerge "char_origin"
$bonemerge "knee_R"
$bonemerge "ankle_R"
$bonemerge "toeBall_R"
$bonemerge "Spine_1"
$bonemerge "Spine_2"
$bonemerge "flag1"
$bonemerge "clavicle_L"
$bonemerge "Wing1_0_R"
$bonemerge "clavicle_R"
$bonemerge "Wing0_0_L"
$bonemerge "Head_0"
$bonemerge "bicep_L"
$bonemerge "elbow_L"
$bonemerge "wrist_L"
$bonemerge "ring_0_L"
$bonemerge "index_0_L"
$bonemerge "thumb_0_L"
$bonemerge "mid_0_L"
$bonemerge "ring_1_L"
$bonemerge "index_1_L"
$bonemerge "thumb_1_L"
$bonemerge "mid_1_L"
$bonemerge "Wing1_1_R"
$bonemerge "Wing1_2_R"
$bonemerge "bicep_R"
$bonemerge "elbow_R"
$bonemerge "wrist_R"
$bonemerge "thumb_0_R"
$bonemerge "ring_0_R"
$bonemerge "index_0_R"
$bonemerge "mid_0_R"
$bonemerge "thumb_1_R"
$bonemerge "ring_1_R"
$bonemerge "index_1_R"
$bonemerge "mid_1_R"
$bonemerge "Wing0_1_L"
$bonemerge "Wing0_2_L"
$bonemerge "Head_1"
$bonemerge "jaw"
$bonemerge "flag2"
$bonemerge "tail0_1"
$bonemerge "tail0_2"
$bonemerge "tail0_3"
$bonemerge "knee_L"
$bonemerge "ankle_L"
$bonemerge "toeBall_L"


$sectionframes 30 929

$sequence "BindPose" {
	"roshan_sfm_anims\BindPose.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "roshan_attack" {
	"roshan_sfm_anims\roshan_attack.smd"
	fadein 0.2
	fadeout 0.2
	fps 24
}

$KeyValues
{
}
