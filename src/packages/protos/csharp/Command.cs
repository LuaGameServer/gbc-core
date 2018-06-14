// Generated by the protocol buffer compiler.  DO NOT EDIT!
// source: command.proto
#pragma warning disable 1591, 0612, 3021
#region Designer generated code

using pb = global::Google.Protobuf;
using pbc = global::Google.Protobuf.Collections;
using pbr = global::Google.Protobuf.Reflection;
using scg = global::System.Collections.Generic;
namespace Pb {

  /// <summary>Holder for reflection information generated from command.proto</summary>
  public static partial class CommandReflection {

    #region Descriptor
    /// <summary>File descriptor for command.proto</summary>
    public static pbr::FileDescriptor Descriptor {
      get { return descriptor; }
    }
    private static pbr::FileDescriptor descriptor;

    static CommandReflection() {
      byte[] descriptorData = global::System.Convert.FromBase64String(
          string.Concat(
            "Cg1jb21tYW5kLnByb3RvEgJwYiI1CgRQYWNrEg4KBmFjdGlvbhgBIAEoCRIP",
            "Cgdjb250ZW50GAIgASgMEgwKBHR5cGUYAyABKAViBnByb3RvMw=="));
      descriptor = pbr::FileDescriptor.FromGeneratedCode(descriptorData,
          new pbr::FileDescriptor[] { },
          new pbr::GeneratedClrTypeInfo(null, new pbr::GeneratedClrTypeInfo[] {
            new pbr::GeneratedClrTypeInfo(typeof(global::Pb.Pack), global::Pb.Pack.Parser, new[]{ "Action", "Content", "Type" }, null, null, null)
          }));
    }
    #endregion

  }
  #region Messages
  public sealed partial class Pack : pb::IMessage<Pack> {
    private static readonly pb::MessageParser<Pack> _parser = new pb::MessageParser<Pack>(() => new Pack());
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public static pb::MessageParser<Pack> Parser { get { return _parser; } }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public static pbr::MessageDescriptor Descriptor {
      get { return global::Pb.CommandReflection.Descriptor.MessageTypes[0]; }
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    pbr::MessageDescriptor pb::IMessage.Descriptor {
      get { return Descriptor; }
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public Pack() {
      OnConstruction();
    }

    partial void OnConstruction();

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public Pack(Pack other) : this() {
      action_ = other.action_;
      content_ = other.content_;
      type_ = other.type_;
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public Pack Clone() {
      return new Pack(this);
    }

    /// <summary>Field number for the "action" field.</summary>
    public const int ActionFieldNumber = 1;
    private string action_ = "";
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public string Action {
      get { return action_; }
      set {
        action_ = pb::ProtoPreconditions.CheckNotNull(value, "value");
      }
    }

    /// <summary>Field number for the "content" field.</summary>
    public const int ContentFieldNumber = 2;
    private pb::ByteString content_ = pb::ByteString.Empty;
    /// <summary>
    /// actions的参数
    /// </summary>
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public pb::ByteString Content {
      get { return content_; }
      set {
        content_ = pb::ProtoPreconditions.CheckNotNull(value, "value");
      }
    }

    /// <summary>Field number for the "type" field.</summary>
    public const int TypeFieldNumber = 3;
    private int type_;
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public int Type {
      get { return type_; }
      set {
        type_ = value;
      }
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public override bool Equals(object other) {
      return Equals(other as Pack);
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public bool Equals(Pack other) {
      if (ReferenceEquals(other, null)) {
        return false;
      }
      if (ReferenceEquals(other, this)) {
        return true;
      }
      if (Action != other.Action) return false;
      if (Content != other.Content) return false;
      if (Type != other.Type) return false;
      return true;
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public override int GetHashCode() {
      int hash = 1;
      if (Action.Length != 0) hash ^= Action.GetHashCode();
      if (Content.Length != 0) hash ^= Content.GetHashCode();
      if (Type != 0) hash ^= Type.GetHashCode();
      return hash;
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public override string ToString() {
      return pb::JsonFormatter.ToDiagnosticString(this);
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public void WriteTo(pb::CodedOutputStream output) {
      if (Action.Length != 0) {
        output.WriteRawTag(10);
        output.WriteString(Action);
      }
      if (Content.Length != 0) {
        output.WriteRawTag(18);
        output.WriteBytes(Content);
      }
      if (Type != 0) {
        output.WriteRawTag(24);
        output.WriteInt32(Type);
      }
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public int CalculateSize() {
      int size = 0;
      if (Action.Length != 0) {
        size += 1 + pb::CodedOutputStream.ComputeStringSize(Action);
      }
      if (Content.Length != 0) {
        size += 1 + pb::CodedOutputStream.ComputeBytesSize(Content);
      }
      if (Type != 0) {
        size += 1 + pb::CodedOutputStream.ComputeInt32Size(Type);
      }
      return size;
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public void MergeFrom(Pack other) {
      if (other == null) {
        return;
      }
      if (other.Action.Length != 0) {
        Action = other.Action;
      }
      if (other.Content.Length != 0) {
        Content = other.Content;
      }
      if (other.Type != 0) {
        Type = other.Type;
      }
    }

    [global::System.Diagnostics.DebuggerNonUserCodeAttribute]
    public void MergeFrom(pb::CodedInputStream input) {
      uint tag;
      while ((tag = input.ReadTag()) != 0) {
        switch(tag) {
          default:
            input.SkipLastField();
            break;
          case 10: {
            Action = input.ReadString();
            break;
          }
          case 18: {
            Content = input.ReadBytes();
            break;
          }
          case 24: {
            Type = input.ReadInt32();
            break;
          }
        }
      }
    }

  }

  #endregion

}

#endregion Designer generated code