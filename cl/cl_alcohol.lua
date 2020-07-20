local soberTimer = 0
local high = false
local lastDrunkness = 0
local drunkness = 0

function OnPackageStart()
	soberTimer = CreateTimer(SoberUp, 60000)
	SetDrunkEffect()
end
AddEvent("OnPackageStart", OnPackageStart)

function ConsumeAlcohol(amount)
    drunkness = drunkness + amount
	SetDrunkEffect()
end
AddRemoteEvent("YRPF:Alcohol:DrugsConsumeAlcohol", ConsumeAlcohol)

function SoberUp()
	if drunkness > 0 then
		drunkness = drunkness - 1
		SetDrunkEffect()
	end
end

function SetDrunkEffect()
	if drunkness > 3 then
		if not high then
			SetCameraShakeFOV(0,0)
			SetCameraShakeRotation(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			StopCameraShake()

			SetPostEffect("Bloom", "Insensity", 1.0)
			SetPostEffect("WhiteBalance", "Tint", (0.05 * drunkness))
			SetPostEffect("DepthOfField", "DepthBlurRadius", (drunkness * 2))

			local dist = 150 - (drunkness * 10)
			if dist <= 1 then
				dist = 1
			end
			SetPostEffect("DepthOfField", "Distance", dist)

			local vig = (drunkness * 0.08) + 0.2
			if vig >= 1.7 then
				vig = 1.7
			end

			local gain = drunkness * 0.05
			if gain >= 0.65 then
				gain = 0.65
			end
			SetPostEffect("ImageEffects", "VignetteIntensity", vig)
			SetPostEffect("Global", "Gain", (1.0 - gain), (1.0 - gain), (1.0 - gain),1.0)

			SetPostEffect("ImageEffects", "GrainIntensity", (drunkness * 0.1))
			

			SetCameraShakeRotation(0.0, 0.2, (drunkness * 0.2), 3.0, 0.0, 0.0)
			PlayCameraShake(420000.0, 2.0, 1.0, (drunkness * 0.25))
		end
		lastDrunkness = drunkness
	else
		if lastDrunkness > 2 then
			if not high then
				SetDefaultPost(0)
			end
			lastDrunkness = drunkness
		end
	end
end

function SetDefaultPost(id)
	if id ~= 0 then
		high = false
	end
	if id == drugID or id == 0 then
		StartCameraFade(0.0, 0.5, 0.6, '#fff')
		Delay(700, function()
			SetCameraShakeFOV(0,0)
			SetCameraShakeRotation(0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
			StopCameraShake()
			StartCameraFade(5.0, 0.0, 0.6, '#fff')
			SetPostEffect("Global", "Gamma", 1,1,1,1)
			SetPostEffect("Global", "Gain", 1,1,1,1)
			SetPostEffect("Global", "Saturation", 1,1,1,1)

			SetPostEffect("WhiteBalance", "Temp", 7500)
			SetPostEffect("WhiteBalance", "Tint", 0.0)

			
			
			SetPostEffect("Chromatic", "Intensity", 0.0)
			SetPostEffect("Chromatic", "StartOffset", 0.0)

			SetPostEffect("MotionWhiteBalanceBlur", "Temp", 7500)

			SetPostEffect("MotionBlur", "Amount", 0.05)
			SetPostEffect("MotionBlur", "Max", 1.0)
			
			SetPostEffect("Bloom", "Insensity", 1.0)

			SetPostEffect("DepthOfField", "DepthBlurRadius", 0.02)
			SetPostEffect("DepthOfField", "Distance", 500.0)
			SetPostEffect("DepthOfField", "DepthBlurSmoothKM", 0.5)

			SetPostEffect("ImageEffects", "GrainIntensity", 0.0)
			SetPostEffect("ImageEffects", "GrainJitter", 1.0)
			SetPostEffect("ImageEffects", "VignetteIntensity", 0.4)
		end)
	end
end