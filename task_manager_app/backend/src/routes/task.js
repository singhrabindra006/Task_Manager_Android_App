const express = require("express");
const auth = require("../middleware/authMiddleware");
const Task = require("../models/task");

const taskRouter = express.Router();

taskRouter.post("/addTask", auth, async (req, res) => {
  try {
    const { title, description, hexColor, dueAt } = req.body;
    const userId = req.user._id;

    const newTask = new Task({
      title,
      description,
      hexColor,
      uid: userId,
      ...(dueAt && { dueAt: new Date(dueAt) }),
    });

    const savedTask = await newTask.save();
    res.status(201).json(savedTask);
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: e.message });
  }
});

taskRouter.get("/getAllTask", auth, async (req, res) => {
  try {
    const userId = req.user._id;
    const tasks = await Task.find({ uid: userId }).sort({ dueAt: 1 });
    res.status(200).json(tasks);
  } catch (e) {
    res.status(500).json({ message: message.e });
  }
});

taskRouter.delete("/deleteTask", auth, async (req, res) => {
  try {
    const { taskId } = req.body;
    const userId = req.user._id;

    const task = await Task.findById(taskId);
    if (!task) {
      return res.status(404).json({ message: "Task not found!" });
    }
    if (task.uid.toString() !== userId.toString()) {
      return res
        .status(403)
        .json({ message: "You are not authorized to delete this task!" });
    }
    await task.deleteOne();
    res.json({ success: true, message: "Task deleted Successfully!" });
  } catch (e) {
    console.error(e);
    res.status(500).json({ message: e.message });
  }
});

module.exports = { taskRouter };
