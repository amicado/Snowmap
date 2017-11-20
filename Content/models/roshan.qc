// Created by Crowbar 0.49.0.0

$modelname "creeps/roshan/roshan.mdl"

$bodygroup "default"
{
	studio "roshan_model.smd"
}

$lod 1
{
	replacemodel "roshan_model.smd" "roshan_model_lod1.smd"
	replacebone "char_origin" "Root_0"
}

$surfaceprop "default"

$contents "solid"

$maxeyedeflection 90

$cdmaterials "models\creeps\roshan"
$cdmaterials ""

$attachment "attach_attack2" "wrist_L" 0 0 0 rotate 0 0 0
$attachment "attach_attack1" "wrist_R" 0 0 0 rotate 0 0 0
$attachment "attach_hitloc" "Spine_2" 0 0 0 rotate 0 0 0

$cbox 0 0 0 0 0 0

$bbox -231.333 -214.668 -13.556 171.125 212.974 355.867

// $hboxset "default"
// $hbox 0 "wrist_L" -6.426128 -17.70697 -41.240303 74.675056 45.417442 27.160337 "wrist_L"
// $hbox 0 "elbow_L" -18.462805 -43.949417 -7.873952 73.971611 17.828669 43.712368 "elbow_L"
// $hbox 0 "bicep_L" -18.303968 -31.329302 -24.56666 72.704216 23.256403 26.211985 "bicep_L"
// $hbox 0 "Head_1" -10.598272 -46.634651 -42.743725 63.479469 46.634651 22.793125 "Head_1"
// $hbox 0 "Wing0_2_L" -34.048695 -21.231861 -22.826977 155.168533 38.57106 34.446331 "Wing0_2_L"
// $hbox 0 "Wing0_1_L" -38.578632 -16.241798 15.240955 66.935249 47.026245 53.35244 "Wing0_1_L"
// $hbox 0 "Wing0_0_L" -13.7048 -15.045415 -10.494563 61.358257 18.099966 16.907343 "Wing0_0_L"
// $hbox 0 "wrist_R" -74.675056 -45.417439 -27.160334 4.59135 17.70697 41.240299 "wrist_R"
// $hbox 0 "elbow_R" -77.090286 -20.108126 -35.547848 18.462805 43.949417 12.379481 "elbow_R"
// $hbox 0 "bicep_R" -73.256386 -19.338467 -27.659405 18.303968 24.615614 26.63814 "bicep_R"
// $hbox 0 "Wing1_2_R" -159.124649 -34.175751 -47.946083 34.405323 24.926456 14.601274 "Wing1_2_R"
// $hbox 0 "Wing1_1_R" -66.935249 -8.987332 -55.737137 14.014477 16.473684 -16.693665 "Wing1_1_R"
// $hbox 0 "Wing1_0_R" -61.358257 -18.099966 -16.907343 13.7048 15.045415 10.494563 "Wing1_0_R"
// $hbox 0 "Spine_2" -13.11989 -52.013161 -57.788475 62.376945 52.013161 51.687553 "Spine_2"
// $hbox 0 "Spine_1" -26.275478 -54.554207 -59.754433 66.625977 56.225147 62.912083 "Spine_1"
// $hbox 0 "Spine_0" -10.985093 -45.714195 -50.260929 54.461044 45.714195 64.036827 "Spine_0"
// $hbox 0 "ankle_L" -13.776585 -23.896254 -18.026945 75.528946 14.124425 21.165104 "ankle_L"
// $hbox 0 "knee_L" -11.456504 -14.075042 -10.453835 66.259911 18.356628 25.848101 "knee_L"
// $hbox 0 "thigh_L" -4.720778 -26.701151 -25.512648 94.45369 19.817305 27.521757 "thigh_L"
// $hbox 0 "ankle_R" -75.528946 -15.488759 -21.165104 13.776585 22.531921 18.026945 "ankle_R"
// $hbox 0 "knee_R" -66.259911 -18.356628 -25.848101 11.456504 14.075042 10.453835 "knee_R"
// $hbox 0 "thigh_R" -94.45369 -29.503872 -25.639967 4.720778 19.50563 23.630857 "thigh_R"
// $hbox 0 "tail0_3" 2.133259 -8.39517 -7.643862 30.150232 8.39517 18.543097 "tail0_3"
// $hbox 0 "tail0_2" 3.166167 -12.183161 -17.886847 63.173973 12.183161 16.177401 "tail0_2"
// $hbox 0 "tail0_1" -2.448216 -17.431274 -20.2255 45.841816 17.431274 25.97736 "tail0_1"
// $hbox 0 "tail0_0" -2.471666 -32.677612 -31.396275 59.432652 32.677612 39.582176 "tail0_0"
// $hbox 0 "Root_0" -41.700005 -47.048298 -45.9366 48.435093 47.048298 16.068556 "Root_0"
// $hboxset "hands"
// $hbox 0 "wrist_L" -6.426128 -17.70697 -41.240303 74.675056 45.417442 27.160337 "wrist_L"
// $hbox 0 "wrist_R" -74.675056 -45.417439 -27.160334 4.59135 17.70697 41.240299 "wrist_R"
// $hboxset "head"
// $hbox 0 "Head_1" -10.598272 -46.634651 -42.743725 63.479469 46.634651 22.793125 "Head_1"
// $hboxset "feet"
// $hbox 0 "ankle_L" -13.776585 -23.896254 -18.026945 75.528946 14.124425 21.165104 "ankle_L"
// $hbox 0 "ankle_R" -75.528946 -15.488759 -21.165104 13.776585 22.531921 18.026945 "ankle_R"
// $hboxset "select_high"
// $hbox 0 "char_origin" -49.659088 1.724879 -74.10376 49.659088 219.468613 48.627811 "char_origin"
// $hboxset "select_low"
// $hbox 0 "char_origin" -81.77626 -0.820739 -82.277016 81.77626 258.325928 78.232231 "char_origin"
// $skipboneinbbox


$sectionframes 30 160

$sequence "BindPose" {
	"roshan_anims\BindPose.smd"
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "roshan_run" {
	"roshan_anims\roshan_run.smd"
	activity "ACT_DOTA_RUN" 1
	{ event AE_CL_PLAYSOUND 10 "Roshan.Footstep" }
	{ event AE_CL_PLAYSOUND 30 "Roshan.Footstep" }
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "roshan_attack" {
	"roshan_anims\roshan_attack.smd"
	activity "ACT_DOTA_ATTACK" 1
	{ event AE_DOTA_PLAY_SOUND_ATTACK 9 "" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "roshan_attack2" {
	"roshan_anims\roshan_attack2.smd"
	activity "ACT_DOTA_ATTACK" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "roshan_idle" {
	"roshan_anims\roshan_idle.smd"
	activity "ACT_DOTA_IDLE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "roshan_die" {
	"roshan_anims\roshan_die.smd"
	activity "ACT_DOTA_DIE" 1
	{ event AE_CL_PLAYSOUND 1 "Roshan.Death" }
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "roshan_slam" {
	"roshan_anims\roshan_slam.smd"
	activity "ACT_DOTA_CAST_ABILITY_3" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "roshan_stun" {
	"roshan_anims\roshan_stun.smd"
	activity "ACT_DOTA_DISABLED" 1
	fadein 0.2
	fadeout 0.2
	fps 30
	loop
}

$sequence "roshan_stun_to_idle" {
	"roshan_anims\roshan_stun_to_idle.smd"
	activity "ACT_DOTA_DISABLED_END" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "roshan_flail" {
	"roshan_anims\roshan_flail.smd"
	activity "ACT_DOTA_FLAIL" 1
	fadein 0.2
	fadeout 0.2
	fps 36
	loop
}

$sequence "roshan_portrait" {
	"roshan_anims\roshan_portrait.smd"
	activity "ACT_DOTA_CAPTURE" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "sr_roshan_firebreath" {
	"roshan_anims\sr_roshan_firebreath.smd"
	activity "ACT_DOTA_CAST_ABILITY_1" 1
	fadein 0.2
	fadeout 0.2
	fps 30
}

$sequence "roshan_death_frostivus" {
	"roshan_anims\roshan_death_frostivus.smd"
	activity "ACT_DOTA_DIE" 1
	activitymodifier frostivus
	{ event AE_CL_PLAYSOUND 24 "BodyImpact_Common.Heavy" }
	fadein 0.2
	fadeout 0.2
	fps 35
}

$KeyValues
{
}
