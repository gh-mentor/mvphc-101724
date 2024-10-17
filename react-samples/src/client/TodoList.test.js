import React from 'react';
import { render, fireEvent } from '@testing-library/react';
import TodoList from './TodoList';


/*
Test case 1:
Render the TodoList component and verify that the input and button are present
Use getByRole to get the input element
Use getByText to get the button element
*/
test('adds a todo item', () => {
  const { getByText, getByRole, getByPlaceholderText } = render(<TodoList />);
  const input = getByRole('textbox');
  const addButton = getByText(/add todo/i);

  fireEvent.change(input, { target: { value: 'Learn React' } });
  fireEvent.click(addButton);

  expect(getByText('Learn React')).toBeInTheDocument();
});

/*
Test case 2:
Render the TodoList component.  
Add a todo item.
Click the delete button for the todo item.
Verify that the todo item is removed from the list.

*/
test('deletes a todo item', () => {
  const { getByText, getByRole, getByPlaceholderText, queryByText } = render(<TodoList />);
  const input = getByRole('textbox');
  const addButton = getByText(/add todo/i);

  fireEvent.change(input, { target: { value: 'Learn React' } });
  fireEvent.click(addButton);

  const deleteButton = getByText(/delete/i);
  fireEvent.click(deleteButton);

  expect(queryByText('Learn React')).toBeNull();
});