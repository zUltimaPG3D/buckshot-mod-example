extends MenuManager.Global.ModNode

var my_settings_screen:Panel
var lab:Label

var setting_alpha_slider:HSlider
var setting_alpha_indicator:Label
var setting_alpha:int = 255

func SetupSettings():
    var panel_container:PanelContainer = PanelContainer.new()
    panel_container.size.x = my_settings_screen.size.x - 40
    panel_container.size.y = my_settings_screen.size.y - 40 - my_settings_screen.get_node("CloseButton").size.y - 20
    panel_container.position.x = 20
    panel_container.position.y = 20
    var vbox:VBoxContainer = VBoxContainer.new()
    vbox.custom_minimum_size = panel_container.size
    setting_alpha_slider = HSlider.new()
    setting_alpha_slider.max_value = 255
    setting_alpha_slider.value = 255
    setting_alpha_slider.rounded = true
    setting_alpha_slider.step = 1
    setting_alpha_indicator = Label.new()

    my_settings_screen.add_child(panel_container)
    panel_container.add_child(vbox)
    vbox.add_child(setting_alpha_indicator)
    vbox.add_child(setting_alpha_slider)

func _enter_tree():
    get_mod_node("settings").register_for_settings(get_mod().id)
    my_settings_screen = get_mod_node("settings").BasicSettingsScreen()
    SetupSettings()
    get_mod_node("settings").register_settings_screen(get_mod().id, my_settings_screen)

    var ctrl:Control = Control.new()
    get_tree().root.add_child(ctrl)

    lab = Label.new()
    lab.text = "Hello from \"{my_name_here}\"!".format({"my_name_here": get_mod().name})
    lab.add_theme_font_override("font", MenuManager.Global.instance.fake_receipt)
    ctrl.add_child.call_deferred(lab)

func _process(_delta):
    setting_alpha = setting_alpha_slider.value if is_instance_valid(setting_alpha_slider) else 255
    if is_instance_valid(lab): lab.self_modulate.a8 = setting_alpha
    if is_instance_valid(setting_alpha_indicator): setting_alpha_indicator.text = "Hello text alpha ({x}):".format({"x": setting_alpha})
