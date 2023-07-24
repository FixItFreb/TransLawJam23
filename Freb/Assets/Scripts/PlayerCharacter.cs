using Godot;
using System;

public partial class PlayerCharacter : StaticBody3D
{
    [Export] public string playerName;
    [Export] public float moveSpeed = 0.5f;
    [Export] private Node3D playerNode;
    [Export] private AnimationPlayer animPlayer;
    [Export] public Color slimeCol = new Color("b57eff");
    [Export] private MeshInstance3D mesh;

    private Vector3 moveDirection = Vector3.Zero;
    private bool isMoving = false;

    public PlayerCharacter(string _playerName, Color _slimeCol)
    {
        playerName = _playerName;
        slimeCol = _slimeCol;
    }

    public void SetCol(Color newCol)
    {
        slimeCol = newCol;
        mesh.GetSurfaceOverrideMaterial(0).Set("albedo_color", slimeCol);
    }

    public override void _Ready()
    {
        SetCol(slimeCol);
    }

    public override void _Process(double delta)
    {
        if (isMoving)
        {
            if (animPlayer.CurrentAnimation != "Slime_WALK")
            {
                animPlayer.Play("Slime_WALK");
            }

            // Vector3 up = Vector3.Up;
            // Vector3 back = -moveDirection;
            // Vector3 right = new Vector3(back.Z, 0.0f, -back.X);
            // Transform3D meshTransform = mesh.GlobalTransform;
            // meshTransform.Basis = new Basis(right, up, back);
            // mesh.GlobalTransform = meshTransform;

            playerNode.LookAt(playerNode.GlobalPosition + moveDirection, Vector3.Up);
        }
        if(!isMoving && animPlayer.CurrentAnimation != "Slime_IDLE")
        {
            animPlayer.Play("Slime_IDLE");
        }
    }

    public override void _PhysicsProcess(double delta)
    {
        moveDirection = Vector3.Zero;

        if(Input.IsActionPressed("up"))
        {
            moveDirection.Z = -1.0f;
        }
        if (Input.IsActionPressed("down"))
        {
            moveDirection.Z = 1.0f;
        }
        if (Input.IsActionPressed("left"))
        {
            moveDirection.X = -1.0f;
        }
        if (Input.IsActionPressed("right"))
        {
            moveDirection.X = 1.0f;
        }

        isMoving = moveDirection.Length() > 0;
        moveDirection = moveDirection.Normalized();
        MoveAndCollide(moveDirection * moveSpeed * (float)delta);
    }
}
