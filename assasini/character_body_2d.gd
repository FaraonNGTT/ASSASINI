extends CharacterBody2D

@export var speed: float = 300.0        # скорость движения
@export var jump_velocity: float = -400.0  # начальная скорость прыжка (отрицательная = вверх)
@export var gravity: float = 980.0     # сила гравитации (пиксели/сек²)

func _physics_process(delta: float) -> void:
	# Добавляем гравитацию, если персонаж не на полу
	if not is_on_floor():
		velocity.y += gravity * delta

	# Горизонтальное движение: -1 (влево), 0, +1 (вправо)
	var direction: float = Input.get_axis("ui_left", "ui_right")
	velocity.x = direction * speed

	# Прыжок при нажатии пробела (действие "ui_accept") и если персонаж на полу
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = jump_velocity

	# Применяем движение и обрабатываем столкновения
	move_and_slide()
