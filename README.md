# SliderModule
This is a module I made for slider GUIs which works with scale instead of the widely used offset.

# Getting Started

## Installation
You can get the module with copying the module from src/shared or you can use Wally to get the module:

Add this to your [dependencies]:

```
SliderModule = "aerodymier/slidermodule@^0.1.2"
```

... or just get it from Roblox creator marketplace:

https://www.roblox.com/library/10138561854/SliderModule

## Usage
You can create a new Slider instance with ``SliderModule.new()``:

```lua
local newSlider = SliderModule.new(slidingBase, sliderMarker, sliderButton, 
{
    min = min,
    max = max,
    snapFactor = snapFactor
}, 
{
    TextBox = valueText
})
```

``slidingBase`` is the frame slider head will slide on. (Type: Frame) (Required)

``sliderMarker`` is the slider head. (Type: Frame) (Required)

``sliderButton`` is the button which needs to be parented to the slideMarker. (Type: TextButton or ImageButton) (Required)

Fourth variable is ``sliderConfigurations``. This one has to have ``min``, ``max``, ``snapFactor`` values. (All required)

- ``min``: Minimum value of your slider. (Type: number)
- ``max``: Maximum value of your slider. (Type: number)
- ``snapFactor``: Step value between 0 and 1. (Type: number)

Fifth variable is ``extras``. This one can have a ``TextBox`` or a ``TextLabel`` value. (Not required)

- ``TextLabel``: The TextLabel which will get updated when value changes. Has priority over ``TextBox`` on displaying values. (Type: TextLabel)
- ``TextBox``: If you want the player to set a custom value between ``min`` and ``max`` values manually, use this. This applies the user specified value to ``self.CurrentValue`` when focus is lost from the TextBox with also moving the marker to the suitable location. Has required checks for number entries. If a ``TextLabel`` is not specified, this will get used on displaying values. (Type: TextBox)
- ``Decimals``: The decimals you want to show in the slider ``TextLabel`` or ``TextBox``. Defaults to 1. (Type: number)

There are some events with a ``Slider`` object as well.

``Slider.InteractionBegan`` - Fires when player starts interacting with the slider.
- Type: BindableEvent
- Returns: void

``Slider.InteractionEnded`` - Fires when player stops interacting with the slider.
- Type: BindableEvent
- Returns: (number) LastValue - Returns the last value of the slider

``Slider.ValueChanged`` - Fires when value changes to a new one.
- Type: BindableEvent
- Returns: (number) CurrentValue - Returns the current value of the slider

## Examples
There is also an example of this module working in this repo. Place file is in PlaceFile folder and all scripts are located in src folder.
Warning for beginners, do not sync this with your own project. The default.project.json file is set to overwriting the contents of target services. Instead, you should copy the module or use Wally.

Wally install is broken at the moment.