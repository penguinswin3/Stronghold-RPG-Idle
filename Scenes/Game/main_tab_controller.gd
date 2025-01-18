extends HBoxContainer

@onready var overview_view_panel: PanelContainer = %OverviewViewPanel
@onready var vault_view_panel: PanelContainer = %VaultViewPanel
@onready var gear_view_panel: PanelContainer = %GearViewPanel
@onready var stronghold_view_panel: PanelContainer = %StrongholdViewPanel
@onready var market_view_panel: PanelContainer = %MarketViewPanel
@onready var presets_view_panel: PanelContainer = %PresetsViewPanel

func _on_logo_tab_button_pressed() -> void:
	overview_view_panel.show()
	vault_view_panel.hide()
	gear_view_panel.hide()
	stronghold_view_panel.hide()
	market_view_panel.hide()
	presets_view_panel.hide()

func _on_vault_tab_button_pressed() -> void:
	overview_view_panel.hide()
	vault_view_panel.show()
	gear_view_panel.hide()
	stronghold_view_panel.hide()
	market_view_panel.hide()
	presets_view_panel.hide()


func _on_gear_tab_button_pressed() -> void:
	overview_view_panel.hide()
	vault_view_panel.hide()
	gear_view_panel.show()
	stronghold_view_panel.hide()
	market_view_panel.hide()
	presets_view_panel.hide()


func _on_stronghold_tab_button_pressed() -> void:
	overview_view_panel.hide()
	vault_view_panel.hide()
	gear_view_panel.hide()
	stronghold_view_panel.show()
	market_view_panel.hide()
	presets_view_panel.hide()


func _on_market_tab_button_pressed() -> void:
	overview_view_panel.hide()
	vault_view_panel.hide()
	gear_view_panel.hide()
	stronghold_view_panel.hide()
	market_view_panel.show()
	presets_view_panel.hide()


func _on_presets_tab_button_pressed() -> void:
	overview_view_panel.hide()
	vault_view_panel.hide()
	gear_view_panel.hide()
	stronghold_view_panel.hide()
	market_view_panel.hide()
	presets_view_panel.show()
